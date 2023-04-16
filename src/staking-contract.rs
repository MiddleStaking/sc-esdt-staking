#![no_std]

multiversx_sc::imports!();
multiversx_sc::derive_imports!();

mod pause_module;
mod views_module;
mod staking_info;

use staking_info::StakingPosition;
use staking_info::TokenPosition;

pub const BLOCKS_IN_YEAR: u64 = 60 * 60 * 24 * 365 / 6;
pub const MAX_PERCENTAGE: u64 = 10_000;
pub const DEF_FEES_PERCENTAGE: u64 = 1_000;
pub const DEF_BURN_PERCENTAGE: u64 = 0;
pub const CLOSE_POOL_LOW_GAS_LIMIT: u64 = 5_000_000;

#[multiversx_sc::contract]
pub trait StakingContract:
pause_module::PauseModule+views_module::ViewsModule {
    
    #[init]
    fn init(
        &self,
        def_staked_token: TokenIdentifier,
        fee_wallet: ManagedAddress,
        burn_wallet: ManagedAddress,
        remove_fees_price: BigUint
    ) {
        require!(
            def_staked_token.is_valid_esdt_identifier(),
            "Invalid token"
        );
        self.def_token_identifier().set(def_staked_token);
        self.burn_wallet().set(burn_wallet);
        self.fee_wallet().set(fee_wallet);
        self.remove_fees_price().set(remove_fees_price);
    }

    //Send ESDT to contract as a staking reward
    //optional : Token to stake to get rewards
    //default value : Default Token
    #[endpoint]
    #[payable("*")]
    fn fund(&self,  staked_token: TokenIdentifier) {
        require!(self.not_paused(),"paused");
        let payment = self.call_value().single_esdt();
        require!(
            payment.token_identifier.is_valid_esdt_identifier() && staked_token.is_valid_esdt_identifier(),
            "Invalid token"
        );

        let token_mapper = self.token_position(&staked_token, &payment.token_identifier);
        let mut token_pos = if !token_mapper.is_empty() {
            token_mapper.get()
        } else {
            TokenPosition {
                fee_percentage: DEF_FEES_PERCENTAGE,
                burn_percentage: DEF_BURN_PERCENTAGE,
                balance: BigUint::zero(),
                total_stake: BigUint::zero(),
                total_rewarded: BigUint::zero(),
                last_fund_block: self.blockchain().get_block_nonce(),
                paused: false,
                blocks_to_max: BLOCKS_IN_YEAR,
            }
        };

        require!(!token_pos.paused,"paused");

        self.staked_tokens().insert(staked_token.clone());
        self.rewarded_tokens(&staked_token).insert(payment.token_identifier.clone());

        let fee_amount = if token_pos.fee_percentage > 0 {
            &payment.amount * token_pos.fee_percentage / MAX_PERCENTAGE
        } else {
            BigUint::zero()
        };
        //burn (is not a real burn)
        //tokens are sent to a distinct wallet
        let burn_amount = if token_pos.burn_percentage > 0 {
            &payment.amount * token_pos.burn_percentage / MAX_PERCENTAGE
        } else {
            BigUint::zero()
        };
        require!(
            (token_pos.fee_percentage > 0 && fee_amount > 0)
                || (token_pos.burn_percentage > 0 && burn_amount > 0)
                || (token_pos.fee_percentage == 0 && token_pos.burn_percentage == 0),
            "Amount to low for division"
        );
        let fund_amount = &payment.amount - &fee_amount - &burn_amount;

        if fee_amount > 0 {
            let fee_wallet = self.fee_wallet().get();
            self.send()
                .direct_esdt(&fee_wallet, &payment.token_identifier, 0, &fee_amount);
        }
        if burn_amount > 0 {
            let burn_wallet = self.burn_wallet().get();
            self.send()
                .direct_esdt(&burn_wallet, &payment.token_identifier, 0, &burn_amount);
        }

        token_pos.balance += fund_amount;
        token_pos.last_fund_block=self.blockchain().get_block_nonce();

        token_mapper.set(&token_pos);
    }

    //user stake ESDT to get rewards from pool  in time
    #[payable("*")]
    #[endpoint]
    fn stake(&self, rewarded_token: TokenIdentifier) {

        require!(self.not_paused(),"paused");

        let payment = self.call_value().single_esdt();

        require!(payment.token_identifier.is_valid_esdt_identifier() && rewarded_token.is_valid_esdt_identifier(),"Invalid token");
        //seems like esdt transfert at 0 return "Negative value"
        require!(payment.amount > 0, "Must stake more than 0");

        let caller = self.blockchain().get_caller();
        let token_mapper = self.token_position(&payment.token_identifier, &rewarded_token);

        require!(!token_mapper.is_empty(), "Invalid position");
        
        let stake_mapper = self.staking_position(&caller, &payment.token_identifier, &rewarded_token);
        let mut token_pos = token_mapper.get();

        require!(!token_pos.paused,"paused");

        require!(token_pos.balance > 0 , "No rewards left in pool");

        self.staked_addresses(&payment.token_identifier, &rewarded_token).insert(caller.clone());

        let mut staking_pos = if !stake_mapper.is_empty() {
            stake_mapper.get()
        } else {
            StakingPosition {
                stake_amount: BigUint::zero(),
                last_action_block: self.blockchain().get_block_nonce(),
            }
        };

        //ajout : eviter le renvoi de dust sur le wallet user quand c'est possible
        if payment.token_identifier == rewarded_token
        {
            let reward_amount = self.calculate_rewards(&staking_pos, &token_pos);

            if reward_amount > 0 {
                let current_block = self.blockchain().get_block_nonce();
                staking_pos.last_action_block = current_block;
                staking_pos.stake_amount += &reward_amount;

                token_pos.balance -= &reward_amount;
                token_pos.total_rewarded += &reward_amount;
                token_pos.total_stake += &reward_amount;
            }
        }
        else{
            self.claim_rewards_for_user(&caller, &mut staking_pos, &mut token_pos, &rewarded_token);
        }


        staking_pos.stake_amount += &payment.amount;
        token_pos.total_stake += &payment.amount;

        stake_mapper.set(&staking_pos);
        token_mapper.set(&token_pos);
    }


    //user unstake ESDT from pool and claim rewards
    //if no amount -> unstake all
    #[endpoint]
    fn unstake(
        &self,
        staked_token: TokenIdentifier,
        rewarded_token: TokenIdentifier,
        opt_unstake_amount: OptionalValue<BigUint>,
    ) {
        require!(staked_token.is_valid_esdt_identifier() && rewarded_token.is_valid_esdt_identifier(),"Invalid token");

        let token_mapper = self.token_position(&staked_token, &rewarded_token);
        require!(!token_mapper.is_empty(), "Invalid position");

        let caller = self.blockchain().get_caller();
        let stake_mapper = self.staking_position(&caller, &staked_token, &rewarded_token);
        require!(!stake_mapper.is_empty(), "Invalid position");

        let mut token_pos = token_mapper.get();
        let mut staking_pos = stake_mapper.get();

        let unstake_amount = match opt_unstake_amount {
            OptionalValue::Some(amt) => amt,
            OptionalValue::None => staking_pos.stake_amount.clone(),
        };

        require!(
            unstake_amount > 0 && unstake_amount <= staking_pos.stake_amount,
            "Invalid unstake amount"
        );

        self.claim_rewards_for_user(&caller, &mut staking_pos, &mut token_pos, &rewarded_token);

        token_pos.total_stake -= &unstake_amount;
        staking_pos.stake_amount -= &unstake_amount;

        if staking_pos.stake_amount > 0 {
            stake_mapper.set(&staking_pos);
        } else {
            stake_mapper.clear();
            self.staked_addresses(&staked_token, &rewarded_token).swap_remove(&caller);
        }
        token_mapper.set(&token_pos);

        self.send().direct_esdt(&caller, &staked_token, 0, &unstake_amount);
    }

    //user can claim rewards at any time
    //block position is reseted
    #[endpoint(claimRewards)]
    fn claim_rewards(&self, staked_token: TokenIdentifier, rewarded_token: TokenIdentifier) {
        let caller = self.blockchain().get_caller();
        
        require!(staked_token.is_valid_esdt_identifier() && rewarded_token.is_valid_esdt_identifier(),"Invalid token");

        let token_mapper = self.token_position(&staked_token, &rewarded_token);
        let stake_mapper = self.staking_position(&caller, &staked_token, &rewarded_token);
        require!(!stake_mapper.is_empty() && !token_mapper.is_empty(), "Invalid position");

        let mut staking_pos = stake_mapper.get();
        let mut token_pos = token_mapper.get();

        self.claim_rewards_for_user(&caller, &mut staking_pos, &mut token_pos, &rewarded_token);

        stake_mapper.set(&staking_pos);
        token_mapper.set(&token_pos);
    }
    //user can stake rewards at any time
    //block position is reseted
    //Only for same tokens
    #[endpoint(stakeRewards)]
    fn stake_rewards(&self, staked_token: TokenIdentifier) {
        let caller = self.blockchain().get_caller();
        
        require!(self.not_paused(),"paused");
        
        require!(staked_token.is_valid_esdt_identifier(),"Invalid token");

        let token_mapper = self.token_position(&staked_token, &staked_token);
        let stake_mapper = self.staking_position(&caller, &staked_token, &staked_token);
        require!(!stake_mapper.is_empty() && !token_mapper.is_empty(), "Invalid position");

        let mut staking_pos = stake_mapper.get();
        let mut token_pos = token_mapper.get();

        require!(!token_pos.paused,"paused");

        let reward_amount = self.calculate_rewards(&staking_pos, &token_pos);

        //transfrert from pool to user
        if reward_amount > 0 {
            let current_block = self.blockchain().get_block_nonce();
            staking_pos.last_action_block = current_block;
            staking_pos.stake_amount += &reward_amount;

            token_pos.balance -= &reward_amount;
            token_pos.total_rewarded += &reward_amount;
            token_pos.total_stake += &reward_amount;
        }

        stake_mapper.set(&staking_pos);
        token_mapper.set(&token_pos);
    }
    //called on stake/unstake/claim_rewards
    fn claim_rewards_for_user(
        &self,
        user: &ManagedAddress,
        staking_pos: &mut StakingPosition<Self::Api>,
        token_pos: &mut TokenPosition<Self::Api>,
        rewarded_token: &TokenIdentifier,
    ) {
        let reward_amount = self.calculate_rewards(staking_pos, token_pos);

        let current_block = self.blockchain().get_block_nonce();
        staking_pos.last_action_block = current_block;

        if reward_amount > 0 {
            token_pos.balance -= &reward_amount;
            token_pos.total_rewarded += &reward_amount;
            self.send().direct_esdt(&user, &rewarded_token, 0, &reward_amount);
        }
        //Token & Staking positions are borrowed no need to save here
    }

    //compute rewards amount (read only)
    fn calculate_rewards(
        &self,
        staking_pos: &StakingPosition<Self::Api>,
        token_pos: &TokenPosition<Self::Api>,
    ) -> BigUint {

        let current_block = self.blockchain().get_block_nonce();

        //this should never happen if users blocks are right on time
        if current_block <= staking_pos.last_action_block {
            return BigUint::zero();
        }

        //How many blocks since last user action ?
        let mut block_diff = current_block - staking_pos.last_action_block;
        
        //we dont want block_diff to be higher that the pool speed
        //if user do not claim in due time, he loose potential rewards over time !
        if block_diff > token_pos.blocks_to_max{
            block_diff = token_pos.blocks_to_max;
        }

        //rewards formula is simple but we start to multiply to increase preçision with int division
        //The more user spend time in pool, the more rewards he can claim
        //{USER STAKE} * {%} / {TOTAL STAKE} * {BALANCE REWARDS} / {%} * {TIME} / {MAX TIME} == REWARDS
        &staking_pos.stake_amount * MAX_PERCENTAGE / &token_pos.total_stake * &token_pos.balance
            / MAX_PERCENTAGE
            * block_diff
            / token_pos.blocks_to_max
    }



    //anyone can pay to remove fees deposit from a pool
    //payment only accept main token
    #[endpoint(removePoolFees)]
    #[payable("*")]
    fn remove_pool_fees(&self,  staked_token: &TokenIdentifier, rewarded_token: &TokenIdentifier) {

        require!(self.not_paused(),"paused");

        let payment = self.call_value().single_esdt();
        let def_token_identifier = self.def_token_identifier().get();
        require!(
            payment.token_identifier == def_token_identifier,
            "Invalid payment token"
        );

        //do not remove fees on mail pool
        require!(
            staked_token != &def_token_identifier || rewarded_token != &def_token_identifier,
            "Default pool"
        );

        require!(
            payment.amount == self.remove_fees_price().get(),
            "Invalid payment value"
        );

        let token_mapper = self.token_position(&staked_token, &rewarded_token);
        let mut token_pos = if !token_mapper.is_empty() {
            token_mapper.get()
        } else {
            TokenPosition {
                fee_percentage: 0,
                burn_percentage: 0,
                balance: BigUint::zero(),
                total_stake: BigUint::zero(),
                total_rewarded: BigUint::zero(),
                last_fund_block: self.blockchain().get_block_nonce(),
                paused: false,
                blocks_to_max: BLOCKS_IN_YEAR,
            }
        };

        require!(!token_pos.paused,"pool paused");

        token_pos.fee_percentage = 0;

        self.staked_tokens().insert(staked_token.clone());
        self.rewarded_tokens(&staked_token).insert(rewarded_token.clone());

        token_mapper.set(&token_pos);


        //payment is going to main pool as reward
        //We could eventually call fund() function instead ?
        //we need to test if the self.call_value().single_esdt() get trought sub function !
        
        let def_token_mapper = self.token_position(&def_token_identifier, &def_token_identifier);
        require!(!def_token_mapper.is_empty(), "default pool not set");
        let mut def_token_pos = def_token_mapper.get();

        let fee_amount = if def_token_pos.fee_percentage > 0 {
            &payment.amount * def_token_pos.fee_percentage / MAX_PERCENTAGE
        } else {
            BigUint::zero()
        };
        let burn_amount = if def_token_pos.burn_percentage > 0 {
            &payment.amount * def_token_pos.burn_percentage / MAX_PERCENTAGE
        } else {
            BigUint::zero()
        };

        require!(
            (def_token_pos.fee_percentage > 0 && fee_amount > 0)
                || (def_token_pos.burn_percentage > 0 && burn_amount > 0)
                || (def_token_pos.fee_percentage == 0 && def_token_pos.burn_percentage == 0),
            "Amount to low for division"
        );

        let fund_amount = &payment.amount - &fee_amount - &burn_amount;

        if fee_amount > 0 {
            let fee_wallet = self.fee_wallet().get();
            self.send()
                .direct_esdt(&fee_wallet, &payment.token_identifier, 0, &fee_amount);
        }
        if burn_amount > 0 {
            let burn_wallet = self.burn_wallet().get();
            self.send()
                .direct_esdt(&burn_wallet, &payment.token_identifier, 0, &burn_amount);
        }

        def_token_pos.balance += fund_amount;
        def_token_pos.last_fund_block=self.blockchain().get_block_nonce();
        def_token_mapper.set(&def_token_pos);
        //END OF MAIN POOL

    }
    
    //contract owner car set pool fees and speed
    //Its possible to set fees before first fund
    //we cant open this function as we need to verify token ownerships first for specifics demands
    #[only_owner]
    #[endpoint(setFees)]
    fn set_fees(&self, staked_token: TokenIdentifier, rewarded_token: TokenIdentifier, fees: u64, burn: u64, opt_blocks_to_max: OptionalValue<u64>) {
        require!(
            fees <= MAX_PERCENTAGE && burn <= MAX_PERCENTAGE,
            "Invalid percentage"
        );
        require!(staked_token.is_valid_esdt_identifier() && rewarded_token.is_valid_esdt_identifier(),"Invalid token");
    
        let token_mapper = self.token_position(&staked_token, &rewarded_token);
    
        let mut token_pos = if !token_mapper.is_empty() {
            token_mapper.get()
        } else {
            TokenPosition {
                fee_percentage: DEF_FEES_PERCENTAGE,
                burn_percentage: DEF_BURN_PERCENTAGE,
                balance: BigUint::zero(),
                total_stake: BigUint::zero(),
                total_rewarded: BigUint::zero(),
                last_fund_block: self.blockchain().get_block_nonce(),
                paused: false,
                blocks_to_max: BLOCKS_IN_YEAR,
            }
        };

        token_pos.fee_percentage = fees;
        token_pos.burn_percentage = burn;
        
        let blocks = match opt_blocks_to_max {
            OptionalValue::Some(blk) => blk,
            OptionalValue::None => token_pos.blocks_to_max,
        };      
        token_pos.blocks_to_max=blocks;

        token_mapper.set(&token_pos);
    }


    //edit base contract config
    #[only_owner]
    #[endpoint(setConfig)]
    fn set_config(&self,
        def_staked_token: TokenIdentifier,
        fee_wallet: ManagedAddress,
        burn_wallet: ManagedAddress,
        remove_fees_price: BigUint
    ){
        require!(
            def_staked_token.is_valid_esdt_identifier(),
            "Invalid token"
        );
        self.def_token_identifier().set(def_staked_token);
        self.burn_wallet().set(burn_wallet);
        self.fee_wallet().set(fee_wallet);
        self.remove_fees_price().set(remove_fees_price);
    }

    //Pause existing pool
    #[only_owner]
    #[endpoint(pausePool)]
    fn pause_pool(&self, staked_token: TokenIdentifier, rewarded_token: TokenIdentifier){
        let token_mapper = self.token_position(&staked_token, &rewarded_token);
        require!(!token_mapper.is_empty(), "Invalid position");
        let mut token_pos = token_mapper.get();
        token_pos.paused = true;
        token_mapper.set(&token_pos);
    }
    //Unpause exisiting pool
    #[only_owner]
    #[endpoint(unpausePool)]
    fn unpause_pool(&self, staked_token: TokenIdentifier, rewarded_token: TokenIdentifier){
        let token_mapper = self.token_position(&staked_token, &rewarded_token);
        require!(!token_mapper.is_empty(), "Invalid position");
        let mut token_pos = token_mapper.get();
        token_pos.paused = false;
        token_mapper.set(&token_pos);
    }

    //(eventually) Close position after a year of inactivity and send left tokens to users (stake + rewards)
    #[only_owner]
    #[endpoint(closePool)]
    fn close_pool(&self, staked_token: TokenIdentifier, rewarded_token: TokenIdentifier) -> OperationCompletionStatus{

        let token_mapper = self.token_position(&staked_token, &rewarded_token);
        require!(!token_mapper.is_empty(), "Invalid position");
        let mut token_pos = token_mapper.get();

        require!(self.is_paused() || token_pos.paused,"not paused");
      
        //time limit = last fund + 1 years (in blocks)
        let time_limit = token_pos.last_fund_block + BLOCKS_IN_YEAR;
        require!(self.blockchain().get_block_nonce() > time_limit,"too early");

        for address in self.staked_addresses(&staked_token, &rewarded_token).iter(){
    
            let stake_mapper = self.staking_position(&address, &staked_token, &rewarded_token);
            let mut staking_pos = stake_mapper.get();

            let unstake_amount = staking_pos.stake_amount.clone();
    
            self.claim_rewards_for_user(&address, &mut staking_pos, &mut token_pos, &rewarded_token);
    
            token_pos.total_stake -= &unstake_amount;

            stake_mapper.clear();

            self.staked_addresses(&staked_token, &rewarded_token).swap_remove(&address);
        
            self.send().direct_esdt(&address, &staked_token, 0, &unstake_amount);

            if self.blockchain().get_gas_left() < CLOSE_POOL_LOW_GAS_LIMIT {
                token_mapper.set(&token_pos);
                return OperationCompletionStatus::InterruptedBeforeOutOfGas;
            }
        }

        //if balance left in pool. Some tokens are sent to burn wallet
        if token_pos.balance > 0 && token_pos.total_stake == 0{
            let burn_wallet = self.burn_wallet().get();
            self.send()
                .direct_esdt(&burn_wallet, &rewarded_token, 0, &token_pos.balance);
            token_pos.balance = BigUint::zero();
        }
        
        if token_pos.balance == 0 && token_pos.total_stake == 0{
            token_mapper.clear();
            self.rewarded_tokens(&staked_token).swap_remove(&rewarded_token);

            let rewarded_token_mapper = self.rewarded_tokens(&staked_token);
            if rewarded_token_mapper.is_empty() {
                self.staked_tokens().swap_remove(&staked_token); 
            }
        }
        return OperationCompletionStatus::Completed;

    }


    //POOL POSITION STORAGE
    #[storage_mapper("tokenPosition")]
    fn token_position(
        &self,
        staked_token: &TokenIdentifier,
        rewarded_token: &TokenIdentifier,
    ) -> SingleValueMapper<TokenPosition<Self::Api>>;

    //VIEW AS ARRAY
    #[view(getTokenPosition)]
    fn token_position_detail(&self, staked_token: TokenIdentifier, rewarded_token: TokenIdentifier) -> ManagedVec<BigUint> {
        let token_pos = self.token_position(&staked_token, &rewarded_token).get();
        let mut result = ManagedVec::new();
        result.push(token_pos.balance);
        result.push(token_pos.total_stake);
        result.push(token_pos.total_rewarded);
        result.push(token_pos.fee_percentage.into());
        result.push(token_pos.burn_percentage.into());
        result.push(token_pos.last_fund_block.into());
        result.push(u8::from(token_pos.paused).into());
        result.push(token_pos.blocks_to_max.into());
        result
    }

    //USER POSITION IN POOL STORAGE
    #[storage_mapper("stakingPosition")]
    fn staking_position(
        &self,
        addr: &ManagedAddress,
        staked_token: &TokenIdentifier,
        rewarded_token: &TokenIdentifier,
    ) -> SingleValueMapper<StakingPosition<Self::Api>>;
    
    //VIEW AS ARRAY
    #[view(getStakingPosition)]
    fn staking_position_detail(&self, addr: ManagedAddress, staked_token: TokenIdentifier, rewarded_token: TokenIdentifier) -> ManagedVec<BigUint> {
        let staking_pos = self.staking_position(&addr, &staked_token, &rewarded_token).get();
        let mut result = ManagedVec::new();
        result.push(staking_pos.stake_amount);
        result.push(u64::from(staking_pos.last_action_block).into());
        result               
    }
    //COMPUTE USER REWARDS IN POOL (read only)
    #[view(calculateRewardsForUser)]
    fn calculate_rewards_for_user(&self, addr: ManagedAddress, staked_token: TokenIdentifier, rewarded_token: TokenIdentifier) -> BigUint {
        let staking_pos = self.staking_position(&addr, &staked_token, &rewarded_token).get();
        let token_pos = self.token_position(&staked_token, &rewarded_token).get();
        self.calculate_rewards(&staking_pos, &token_pos)
    }

}
