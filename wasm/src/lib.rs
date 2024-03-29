// Code generated by the multiversx-sc multi-contract system. DO NOT EDIT.

////////////////////////////////////////////////////
////////////////// AUTO-GENERATED //////////////////
////////////////////////////////////////////////////

// Init:                                 1
// Endpoints:                           28
// Async Callback (empty):               1
// Total number of exported functions:  30

#![no_std]

// Configuration that works with rustc < 1.73.0.
// TODO: Recommended rustc version: 1.73.0 or newer.
#![feature(lang_items)]

multiversx_sc_wasm_adapter::allocator!();
multiversx_sc_wasm_adapter::panic_handler!();

multiversx_sc_wasm_adapter::endpoints! {
    staking_contract
    (
        init => init
        fund => fund
        stake => stake
        unstake => unstake
        claimRewards => claim_rewards
        stakeRewards => stake_rewards
        removePoolFees => remove_pool_fees
        setFees => set_fees
        setConfig => set_config
        pausePool => pause_pool
        unpausePool => unpause_pool
        closePool => close_pool
        getTokenPosition => token_position_detail
        getAllTokenPosition => all_token_position_detail
        getAllStakingPosition => all_staking_position_detail
        getAllUserRewards => all_user_rewards
        getStakingPosition => staking_position_detail
        calculateRewardsForUser => calculate_rewards_for_user
        isPaused => is_paused
        pause => pause_endpoint
        unpause => unpause_endpoint
        getDefTokenIdentifier => def_token_identifier
        getBurnWallet => burn_wallet
        getFeeWallet => fee_wallet
        getFeePercent => fee_percent
        getRemoveFeesPrice => remove_fees_price
        getStakedTokens => staked_tokens
        getRewardedTokens => rewarded_tokens
        getStakedAddresses => staked_addresses
    )
}

multiversx_sc_wasm_adapter::async_callback_empty! {}
