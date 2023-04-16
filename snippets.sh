# run-scenarios "/Users/kevinlallement/MultiversX/SmartContracts/staking-contract"

OWNER_PEM="~/MultiversX/wallets/wallet.pem"
USER_PEM="~/MultiversX/wallets/wallet1.pem"
USER_PEM2="~/MultiversX/wallets/wallet2.pem"

OWNER_ADDRESS="erd12stex47hwg0hvx8cfvukj3y3ugs7dm0686k3wasycffexva6ch9s7tvj29"
USER_ADDRESS="erd14e6akvd0nfgtp3zddykj9hhqys5aw0jswctnlyg66k4n2eu7k38s0nzfpr"
USER2_ADDRESS="erd1l9qvkwyzsx3metptzyu0p7zx0r6jjuwv4ukvulfa6qt3xnaj8w3q5ff8es"

FEE_PERC=400
FEE_WALLET="erd1u8nxp4kkt3jqj3uxfftklwntf4fcu3tc9m4h7l9vgyv9l3zd58aqwnn6xz"

BURN_WALLET="erd1z9f7ujxr2j2am6g36hgx2yhn2jvu39fudtz4hkkxmzjp8dv0apqsxe6hjv"
BURN_PERC=6600



#DEVNET : 
SC_ADDRESS="erd1qqqqqqqqqqqqqpgq4dvqaez22usynmp7e3w957q24m6740nkch9s5lvlc7"
PROXY="https://devnet-gateway.multiversx.com"
CHAIN_ID="D"
TOKEN_IDENTIFIER="str:STAKE-1c6362"
TOKEN_IDENTIFIER2="str:BUILDO-890d14"
TOKEN_IDENTIFIER3="str:USDC-79d9a4"

T_MID="str:MID-7f1d59"
T_WEGLD="str:WEGLD-d7c6bb"
T_STAKE="str:STAKE-1c6362"
T_VITAL="str:VITAL-058fd5"
T_BKT="str:BKT-6561e8"

STAKE_AMOUNT=10000000000000000
UNSTAKE_AMOUNT=1000000000000000
TOKEN_DEPOSIT=1000000000000000000
TOKEN_STAKE=10000000000000000
TOKEN_STAKE2=10000000000000000
BLOCSPEEDM=438000
BLOCSPEEDY=5256000
BLOCSPEEDYY=10512000

CUTFEESVALUE=5000000000000000000000

# #MAINNET :
# SC_ADDRESS="erd1qqqqqqqqqqqqqpgqnyaznr0q3m8u79secaydqtedktp59r2dch9syz2wlf"
# PROXY="https://gateway.multiversx.com"
# CHAIN_ID="1"
# TOKEN_IDENTIFIER="str:MID-ec"
# TOKEN_IDENTIFIER2="str:OFD-b9989d"
# STAKE_AMOUNT=1000000000000000000
# UNSTAKE_AMOUNT=1000000000000000
# TOKEN_DEPOSIT=100000000000000000000
# TOKEN_STAKE=10000000000000000
# TOKEN_STAKE2=1000000000000000000

# LEDGER account 2 : erd175f5khy03nuctjfxre29kza4je8e48xsfu56fzwgmwqtty33txfqse8h4k
#Deploi le contrat
deploy() {
    mxpy --verbose contract deploy --project=${PROJECT} \
    --recall-nonce --pem=${OWNER_PEM} \
    --gas-limit=46000000 \
    --send --outfile="deploy-devnet.interaction.json" \
    --arguments ${T_MID} ${FEE_WALLET} ${BURN_WALLET} ${CUTFEESVALUE} \
    --proxy=${PROXY} --chain=${CHAIN_ID} || return
}
# mxpy contract deploy --ledger --ledger-address-index 2 --bytecode=output/staking-contract.wasm --gas-limit=60000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --arguments str:"MID-7f1d59" "erd1u8nxp4kkt3jqj3uxfftklwntf4fcu3tc9m4h7l9vgyv9l3zd58aqwnn6xz" "erd1r9j4wwjw7qxqv8ztrl7spdsjwq2lcay2cjj9hl9mg2qvnc82hs3qurz6su" 5000000000000000000000
# mxpy contract deploy --ledger --ledger-address-index 2 --bytecode=output/staking-contract.wasm --gas-limit=60000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --arguments str:"MID-ecb7bf" "erd1u8nxp4kkt3jqj3uxfftklwntf4fcu3tc9m4h7l9vgyv9l3zd58aqwnn6xz" "erd1r9j4wwjw7qxqv8ztrl7spdsjwq2lcay2cjj9hl9mg2qvnc82hs3qurz6su" 5000000000000000000000

#Met à jour le contrat
upgrade() {
    mxpy --verbose contract upgrade ${SC_ADDRESS}  \
    --project=${PROJECT} \
    --recall-nonce --pem=${OWNER_PEM} \
    --gas-limit=46000000 \
    --arguments ${T_MID} ${FEE_WALLET} ${BURN_WALLET} ${CUTFEESVALUE} \
    --send --outfile="upgrade-devnet.interaction.json" \
    --proxy=${PROXY} --chain=${CHAIN_ID} || return
}
# mxpy contract upgrade erd1qqqqqqqqqqqqqpgq4dvqaez22usynmp7e3w957q24m6740nkch9s5lvlc7 --ledger --ledger-address-index 2 --bytecode=output/staking-contract.wasm --gas-limit=60000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --arguments str:"MID-7f1d59" "erd1u8nxp4kkt3jqj3uxfftklwntf4fcu3tc9m4h7l9vgyv9l3zd58aqwnn6xz" "erd1r9j4wwjw7qxqv8ztrl7spdsjwq2lcay2cjj9hl9mg2qvnc82hs3qurz6su" 5000000000000000000000
# mxpy contract upgrade erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --bytecode=output/staking-contract.wasm --gas-limit=60000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --arguments str:"MID-ecb7bf" "erd1u8nxp4kkt3jqj3uxfftklwntf4fcu3tc9m4h7l9vgyv9l3zd58aqwnn6xz" "erd1r9j4wwjw7qxqv8ztrl7spdsjwq2lcay2cjj9hl9mg2qvnc82hs3qurz6su" 5000000000000000000000

#configure les frais et burn pour une pool
#FEES BURN opt:speed
setFees() {
    mxpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${OWNER_PEM} \
    --gas-limit=10000000 \
    --function="setFees" \
    --arguments ${T_MID} ${T_MID} "400" "100"
}
# mxpy contract call erd1qqqqqqqqqqqqqpgq4dvqaez22usynmp7e3w957q24m6740nkch9s5lvlc7 --ledger --ledger-address-index 2 --gas-limit=10000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="setFees" --arguments str:"MID-7f1d59" str:"MID-7f1d59" "400" "100"
# mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --gas-limit=10000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="setFees" --arguments str:"MID-ecb7bf" str:"MID-ecb7bf" "400" "100"

#Met en pause les fonction des fund et stake (allPool)
pause() {
    mxpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${OWNER_PEM} \
    --gas-limit=10000000 \
    --function="pause"
}
# mxpy contract call erd1qqqqqqqqqqqqqpgq4dvqaez22usynmp7e3w957q24m6740nkch9s5lvlc7 --ledger --ledger-address-index 2 --gas-limit=5000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="pause"
# mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --gas-limit=5000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="pause"

#fin de pause fund et stake (allPool)
unpause() {
    mxpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${OWNER_PEM} \
    --gas-limit=10000000 \
    --function="unpause"
}
# mxpy contract call erd1qqqqqqqqqqqqqpgq4dvqaez22usynmp7e3w957q24m6740nkch9s5lvlc7 --ledger --ledger-address-index 2 --gas-limit=5000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="unpause"
# mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --gas-limit=5000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="unpause"





#Dépose des fonds de récompenses dans une pool
#Argument optionnel : Token à stake pour user
fund() {
    mxpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${USER_PEM} \
    --gas-limit=10000000 \
    --function="ESDTTransfer" \
    --arguments ${TOKEN_IDENTIFIER} ${TOKEN_DEPOSIT} "str:fund" 
}


#met en pause la paire (depot et stake)
pausePool() {
    mxpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${OWNER_PEM} \
    --gas-limit=10000000 \
    --function="pausePool" \
    --arguments ${T_MID} ${T_WEGLD}
}
#met en action la paire (depot et stake)
unpausePool() {
    mxpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${OWNER_PEM} \
    --gas-limit=10000000 \
    --function="unpausePool" \
    --arguments ${TOKEN_IDENTIFIER} ${TOKEN_IDENTIFIER}
}
#Ferme la pool et rembourse les users
closePool() {
    mxpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${OWNER_PEM} \
    --gas-limit=10000000 \
    --function="closePool" \
    --arguments ${T_STAKE} ${T_STAKE}
}
#User participe au staking
#Optionnel : token de récompense
stake() {
    mxpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${USER_PEM} \
    --gas-limit=10000000 \
    --function="ESDTTransfer" \
    --arguments ${TOKEN_IDENTIFIER} ${TOKEN_STAKE} "str:stake"
}


#récolte les récompense de stake
#optionnel : token de stake
#optionnel : token de reward
claimRewards() {
    mxpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${USER_PEM} \
    --gas-limit=10000000 \
    --function="claimRewards" \
}

#retire x tokens
unstake() {
    mxpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${USER_PEM} \
    --gas-limit=10000000 \
    --function="unstake" \
    --arguments ${TOKEN_IDENTIFIER} ${TOKEN_IDENTIFIER} ${UNSTAKE_AMOUNT}
}

#retire tous les tokens
unstakeAll() {
    mxpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${USER_PEM} \
    --gas-limit=10000000 \
    --function="unstake"
}

#montant position utilisateur dans la pool
getStakingPosition() {
    mxpy --verbose contract query ${SC_ADDRESS} \
    --proxy=${PROXY} \
    --function="getStakingPosition" \
    --arguments ${USER_ADDRESS} ${TOKEN_IDENTIFIER} ${TOKEN_IDENTIFIER}
}

#Tableau détail position de la pool (balance, total_staken total_rewarded, fee_percentage, burn_percentage, last_fund_block, paused)
getTokenPosition() {
    mxpy --verbose contract query ${SC_ADDRESS} \
    --proxy=${PROXY} \
    --function="getTokenPosition" \
    --arguments ${TOKEN_IDENTIFIER} ${TOKEN_IDENTIFIER}
}

#Paire principale
getStakedTokens() {
    mxpy --verbose contract query ${SC_ADDRESS} \
    --proxy=${PROXY} \
    --function="getStakedTokens"
}
#Paire secondaire
getRewardedTokens() {
    mxpy --verbose contract query ${SC_ADDRESS} \
    --proxy=${PROXY} \
    --function="getRewardedTokens" \
    --arguments ${TOKEN_IDENTIFIER}
}

#Participants dans la paire
getStakedAddresses() {
    mxpy --verbose contract query ${SC_ADDRESS} \
    --proxy=${PROXY} \
    --function="getStakedAddresses" \
    --arguments ${TOKEN_IDENTIFIER} ${TOKEN_IDENTIFIER}
}

#Addresse du wallet de burn
getBurnWallet() {
    mxpy --verbose contract query ${SC_ADDRESS} \
    --proxy=${PROXY} \
    --function="getBurnWallet"
}
#Addresse du wallet de fee
getFeeWallet() {
    mxpy --verbose contract query ${SC_ADDRESS} \
    --proxy=${PROXY} \
    --function="getFeeWallet"
}

#récompenses en attente pour l'utilisateur
calculateRewardsForUser() {
    mxpy --verbose contract query ${SC_ADDRESS} \
    --proxy=${PROXY} \
    --function="calculateRewardsForUser" \
    --arguments ${USER_ADDRESS} ${TOKEN_IDENTIFIER} ${TOKEN_IDENTIFIER}
}


