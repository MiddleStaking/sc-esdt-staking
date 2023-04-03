multiversx_sc::imports!();
multiversx_sc::derive_imports!();


#[multiversx_sc::module]
pub trait ViewsModule {

    //BASICS STORAGES WITH NO STRUCTS
    //Token pour stake et recevoir des rewards
    #[view(getDefTokenIdentifier)]
    #[storage_mapper("defTokenIdentifier")]
    fn def_token_identifier(&self) -> SingleValueMapper<TokenIdentifier>;
    //Burn Wallet
    #[view(getBurnWallet)]
    #[storage_mapper("burnWallet")]
    fn burn_wallet(&self) -> SingleValueMapper<ManagedAddress>;
    //Fee wallet
    #[view(getFeeWallet)]
    #[storage_mapper("feeWallet")]
    fn fee_wallet(&self) -> SingleValueMapper<ManagedAddress>;

    //removeFeesPrice
    #[view(getRemoveFeesPrice)]
    #[storage_mapper("removeFeesPrice")]
    fn remove_fees_price(&self) -> SingleValueMapper<BigUint>;

    //POOLS POSITIONS :
    //STAKEDS TOKENS
    #[view(getStakedTokens)]
    #[storage_mapper("stakedTokens")]
    fn staked_tokens(&self) -> UnorderedSetMapper<TokenIdentifier>;
    //REWARDED TOKENS
    #[view(getRewardedTokens)]
    #[storage_mapper("rewardedTokens")]
    fn rewarded_tokens(&self, staked_token: &TokenIdentifier) -> UnorderedSetMapper<TokenIdentifier>;
    //STAKED USERS ADDRESSES IN POOL
    #[view(getStakedAddresses)]
    #[storage_mapper("stakedAddresses")]
    fn staked_addresses(&self, staked_token: &TokenIdentifier, rewarded_token: &TokenIdentifier) -> UnorderedSetMapper<ManagedAddress>;

    
}