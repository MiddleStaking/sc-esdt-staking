multiversx_sc::imports!();
multiversx_sc::derive_imports!();

//global
#[derive(TypeAbi, TopEncode, TopDecode, PartialEq, Debug, NestedEncode, NestedDecode, ManagedVecItem)]
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
//user
#[derive(TypeAbi, TopEncode, TopDecode, PartialEq, Debug, NestedEncode, NestedDecode, ManagedVecItem)]
pub struct StakingPosition<M: ManagedTypeApi> {
    pub stake_amount: BigUint<M>,
    pub last_action_block: u64,
}

//global
#[derive(TypeAbi, TopEncode, TopDecode, PartialEq, Debug, ManagedVecItem, NestedEncode)]
pub struct TokenPositionView<M: ManagedTypeApi> {
    pub rewarded_token: TokenIdentifier<M>,
    pub token_position: TokenPosition<M>,
    pub staked_addresses: usize,
}
//user
#[derive(TypeAbi, TopEncode, TopDecode, PartialEq, Debug, ManagedVecItem, NestedEncode)]
pub struct StakingPositionView<M: ManagedTypeApi> {
    pub rewarded_token: TokenIdentifier<M>,
    pub staking_position: StakingPosition<M>,
}
//rewards calculation
#[derive(TypeAbi, TopEncode, TopDecode, PartialEq, Debug, ManagedVecItem, NestedEncode)]
pub struct RewardsView<M: ManagedTypeApi> {
    pub rewarded_token: TokenIdentifier<M>,
    pub rewards: BigUint<M>,
}
