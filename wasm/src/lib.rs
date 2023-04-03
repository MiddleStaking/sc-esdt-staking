// Code generated by the multiversx-sc multi-contract system. DO NOT EDIT.

////////////////////////////////////////////////////
////////////////// AUTO-GENERATED //////////////////
////////////////////////////////////////////////////

// Init:                                 1
// Endpoints:                           24
// Async Callback (empty):               1
// Total number of exported functions:  26

#![no_std]
#![feature(alloc_error_handler, lang_items)]

multiversx_sc_wasm_adapter::allocator!();
multiversx_sc_wasm_adapter::panic_handler!();

multiversx_sc_wasm_adapter::endpoints! {
    staking_contract
    (
        fund
        stake
        unstake
        claimRewards
        stakeRewards
        removePoolFees
        setFees
        setConfig
        pausePool
        unpausePool
        closePool
        getTokenPosition
        getStakingPosition
        calculateRewardsForUser
        isPaused
        pause
        unpause
        getDefTokenIdentifier
        getBurnWallet
        getFeeWallet
        getRemoveFeesPrice
        getStakedTokens
        getRewardedTokens
        getStakedAddresses
    )
}

multiversx_sc_wasm_adapter::empty_callback! {}
