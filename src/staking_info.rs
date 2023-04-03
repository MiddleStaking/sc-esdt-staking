multiversx_sc::imports!();
multiversx_sc::derive_imports!();

#[derive(TypeAbi, TopEncode, TopDecode, PartialEq, Debug)]
pub struct TokenPosition<M: ManagedTypeApi> {
    pub fee_percentage: u64,
    pub burn_percentage: u64,
    pub balance: BigUint<M>,
    pub total_stake: BigUint<M>,
    pub total_rewarded: BigUint<M>,
    pub last_fund_block: u64,
    pub paused: bool,
    pub blocks_to_max: u64,
}

#[derive(TypeAbi, TopEncode, TopDecode, PartialEq, Debug)]
pub struct StakingPosition<M: ManagedTypeApi> {
    pub stake_amount: BigUint<M>,
    pub last_action_block: u64,
}