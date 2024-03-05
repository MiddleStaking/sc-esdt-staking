#SNIPET D : erd1qqqqqqqqqqqqqpgq4dvqaez22usynmp7e3w957q24m6740nkch9s5lvlc7
#SNIPET D2 : erd1qqqqqqqqqqqqqpgqnhdcg9ugyall5xyxa8xayz80hp5d3d6gch9s2kragz
#SNIPET 1 : erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2
#DEPLOY & UPGRADE
#  fn init(
#         &self,
#         def_staked_token: TokenIdentifier,
#         fee_wallet: ManagedAddress,
#         burn_wallet: ManagedAddress,
#         remove_fees_price: BigUint,
#         fee_percent: u64
#     )
#DEVNET
#mxpy contract deploy --pem="~/MultiversX/wallets/wallet.pem" --bytecode=output/staking-contract.wasm --gas-limit=70000000 --recall-nonce --proxy="https://devnet2-gateway.multiversx.com" --chain D --send --arguments str:"MID-7f1d59" "erd1u8nxp4kkt3jqj3uxfftklwntf4fcu3tc9m4h7l9vgyv9l3zd58aqwnn6xz" "erd1r9j4wwjw7qxqv8ztrl7spdsjwq2lcay2cjj9hl9mg2qvnc82hs3qurz6su" 25000000000000000000000 500
mxpy contract upgrade erd1qqqqqqqqqqqqqpgq4dvqaez22usynmp7e3w957q24m6740nkch9s5lvlc7 --pem="~/MultiversX/wallets/wallet.pem" --bytecode=output/staking-contract.wasm --gas-limit=70000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --arguments str:"MID-7f1d59" "erd1u8nxp4kkt3jqj3uxfftklwntf4fcu3tc9m4h7l9vgyv9l3zd58aqwnn6xz" "erd1r9j4wwjw7qxqv8ztrl7spdsjwq2lcay2cjj9hl9mg2qvnc82hs3qurz6su" 2500000000000000000000 500
#DEVNET2
#mxpy contract deploy --pem="~/MultiversX/wallets/wallet.pem" --bytecode=output/staking-contract.wasm --gas-limit=70000000 --recall-nonce --proxy="https://devnet2-gateway.multiversx.com" --chain D --send --arguments str:"MID-00c2c9" "erd1u8nxp4kkt3jqj3uxfftklwntf4fcu3tc9m4h7l9vgyv9l3zd58aqwnn6xz" "erd1r9j4wwjw7qxqv8ztrl7spdsjwq2lcay2cjj9hl9mg2qvnc82hs3qurz6su" 25000000000000000000000 500
mxpy contract upgrade erd1qqqqqqqqqqqqqpgqnhdcg9ugyall5xyxa8xayz80hp5d3d6gch9s2kragz --pem="~/MultiversX/wallets/wallet.pem" --bytecode=output/staking-contract.wasm --gas-limit=70000000 --recall-nonce --proxy="https://devnet2-gateway.multiversx.com" --chain D --send --arguments str:"MID-00c2c9" "erd1u8nxp4kkt3jqj3uxfftklwntf4fcu3tc9m4h7l9vgyv9l3zd58aqwnn6xz" "erd1r9j4wwjw7qxqv8ztrl7spdsjwq2lcay2cjj9hl9mg2qvnc82hs3qurz6su" 2500000000000000000000 500
#MAINNET
#mxpy contract deploy --ledger --ledger-address-index 2 --bytecode=output/staking-contract.wasm --gas-limit=70000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --arguments str:"MID-ecb7bf" "erd1u8nxp4kkt3jqj3uxfftklwntf4fcu3tc9m4h7l9vgyv9l3zd58aqwnn6xz" "erd1r9j4wwjw7qxqv8ztrl7spdsjwq2lcay2cjj9hl9mg2qvnc82hs3qurz6su" 25000000000000000000000 500
mxpy contract upgrade erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --bytecode=output/staking-contract.wasm --gas-limit=70000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --arguments str:"MID-ecb7bf" "erd1u8nxp4kkt3jqj3uxfftklwntf4fcu3tc9m4h7l9vgyv9l3zd58aqwnn6xz" "erd1r9j4wwjw7qxqv8ztrl7spdsjwq2lcay2cjj9hl9mg2qvnc82hs3qurz6su" 2000000000000000000000 100

#USE INTERFACE
mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --gas-limit=50000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="clear"





mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --gas-limit=5000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="unpausePool" --arguments str:"MID-ecb7bf" str:"UTK-2f80e9"


# run-scenarios "/Users/kevinlallement/MultiversX/SmartContracts/staking-contract"
mxpy contract call erd1qqqqqqqqqqqqqpgqrjd76ncjamnk6lmv5vmk98c6px02t3wwch9sagt9mk --pem="~/MultiversX/wallets/wallet.pem" --value=50000000000000000 --gas-limit=60000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="issueLpToken" --arguments str:"MID-7f1d59" str:"QWT-0d9aa6" str:"MIDQWT" str:"MIDQWTLP"
mxpy contract call erd1qqqqqqqqqqqqqpgqrjd76ncjamnk6lmv5vmk98c6px02t3wwch9sagt9mk --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=60000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="setLocalRoles" --arguments str:"MID-7f1d59" str:"QWT-0d9aa6"
#mxpy contract call erd1qqqqqqqqqqqqqpgqrjd76ncjamnk6lmv5vmk98c6px02t3wwch9sagt9mk --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=60000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="ESDTTransfer" --arguments str:"MID-7f1d59" 10000 str:"addLp"
mxpy contract call erd1qqqqqqqqqqqqqpgqrjd76ncjamnk6lmv5vmk98c6px02t3wwch9sagt9mk --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=70000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="setLocalRoles" --arguments str:"MID-7f1d59" str:"SNS-ffcb8c"
mxpy contract call erd12stex47hwg0hvx8cfvukj3y3ugs7dm0686k3wasycffexva6ch9s7tvj29 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=60000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="MultiESDTNFTTransfer" --arguments erd1qqqqqqqqqqqqqpgqrjd76ncjamnk6lmv5vmk98c6px02t3wwch9sagt9mk 2 str:"MID-7f1d59" 0 10000000000000000000 str:"SNS-ffcb8c" 0 1000000000000000000  str:"addLp"

mxpy contract upgrade erd1qqqqqqqqqqqqqpgqf63utxdnjxlklutavl5sqamjgsmf5565ch9sdxj750 --pem="~/MultiversX/wallets/wallet.pem" --bytecode=output/staking-contract.wasm --gas-limit=70000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --arguments str:"MID-7f1d59" "erd1u8nxp4kkt3jqj3uxfftklwntf4fcu3tc9m4h7l9vgyv9l3zd58aqwnn6xz" "erd1r9j4wwjw7qxqv8ztrl7spdsjwq2lcay2cjj9hl9mg2qvnc82hs3qurz6su" 5000000000000000000000


#POOL INIT
mxpy contract call erd1qqqqqqqqqqqqqpgqf63utxdnjxlklutavl5sqamjgsmf5565ch9sdxj750 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=10000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="setFees" --arguments str:"MID-7f1d59" str:"MID-7f1d59" "400" "100"
mxpy contract call erd1qqqqqqqqqqqqqpgqf63utxdnjxlklutavl5sqamjgsmf5565ch9sdxj750 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=10000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="setFees" --arguments str:"MID-7f1d59" str:"STAKE-1c6362" "400" "100"

#SWAP INIT
mxpy contract call erd1qqqqqqqqqqqqqpgqf63utxdnjxlklutavl5sqamjgsmf5565ch9sdxj750 --pem="~/MultiversX/wallets/wallet.pem" --value=50000000000000000 --gas-limit=70000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="issueLpToken" --arguments str:"MID-7f1d59" str:"STAKE-1c6362" str:"MISTAKE" str:"MISTAKELP"
mxpy contract call erd1qqqqqqqqqqqqqpgqf63utxdnjxlklutavl5sqamjgsmf5565ch9sdxj750 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=70000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="setLocalRoles" --arguments str:"MID-7f1d59" str:"STAKE-1c6362"

mxpy contract call erd1qqqqqqqqqqqqqpgqf63utxdnjxlklutavl5sqamjgsmf5565ch9sdxj750 --pem="~/MultiversX/wallets/wallet.pem" --value=50000000000000000 --gas-limit=70000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="issueLpToken" --arguments str:"MID-7f1d59" str:"WEGLD-d7c6bb" str:"MIDEGLD" str:"MIDEGLDLP"
mxpy contract call erd1qqqqqqqqqqqqqpgqf63utxdnjxlklutavl5sqamjgsmf5565ch9sdxj750 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=70000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="setLocalRoles" --arguments str:"MID-7f1d59" str:"WEGLD-d7c6bb"

#FIRST LP
mxpy contract call erd12stex47hwg0hvx8cfvukj3y3ugs7dm0686k3wasycffexva6ch9s7tvj29 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=60000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="MultiESDTNFTTransfer" --arguments erd1qqqqqqqqqqqqqpgqf63utxdnjxlklutavl5sqamjgsmf5565ch9sdxj750 2 str:"MID-7f1d59" 0 10000000000000000000 str:"STAKE-1c6362" 0 10000000000000000000  str:"addLp"
mxpy contract call erd1qqqqqqqqqqqqqpgqf63utxdnjxlklutavl5sqamjgsmf5565ch9sdxj750 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=60000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="ESDTTransfer" --arguments str:"MISTAKELP-b33f21" 20000 str:"removeLp" str:"MID-7f1d59" str:"STAKE-1c6362"  

mxpy contract call erd12stex47hwg0hvx8cfvukj3y3ugs7dm0686k3wasycffexva6ch9s7tvj29 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=60000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="MultiESDTNFTTransfer" --arguments erd1qqqqqqqqqqqqqpgqf63utxdnjxlklutavl5sqamjgsmf5565ch9sdxj750 2 str:"MID-7f1d59" 0 1000000000000000000 str:"WEGLD-d7c6bb" 0 1000000000000000000  str:"addLp"
mxpy contract call erd1qqqqqqqqqqqqqpgqf63utxdnjxlklutavl5sqamjgsmf5565ch9sdxj750 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=60000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="ESDTTransfer" --arguments str:"MIDEGLDLP-b5b3ad" 1000 str:"removeLp" str:"MID-7f1d59" str:"WEGLD-d7c6bb"

#SWAP
mxpy contract call erd1qqqqqqqqqqqqqpgqf63utxdnjxlklutavl5sqamjgsmf5565ch9sdxj750 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=60000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="ESDTTransfer" --arguments str:"MID-7f1d59" 1000000000000000000 str:"swap" str:"MID-7f1d59" str:"STAKE-1c6362"
mxpy contract call erd1qqqqqqqqqqqqqpgqf63utxdnjxlklutavl5sqamjgsmf5565ch9sdxj750 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=60000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="ESDTTransfer" --arguments str:"STAKE-1c6362" 1000000000000000000 str:"swap" str:"MID-7f1d59" str:"STAKE-1c6362"


mxpy contract upgrade erd1qqqqqqqqqqqqqpgq4dvqaez22usynmp7e3w957q24m6740nkch9s5lvlc7 --pem="~/MultiversX/wallets/wallet.pem" --bytecode=output/staking-contract.wasm --gas-limit=72000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --arguments str:"MID-7f1d59" "erd1u8nxp4kkt3jqj3uxfftklwntf4fcu3tc9m4h7l9vgyv9l3zd58aqwnn6xz" "erd1r9j4wwjw7qxqv8ztrl7spdsjwq2lcay2cjj9hl9mg2qvnc82hs3qurz6su" 5000000000000000000000 500
# mxpy contract upgrade erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --bytecode=output/staking-contract.wasm --gas-limit=72000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --arguments str:"MID-ecb7bf" "erd1u8nxp4kkt3jqj3uxfftklwntf4fcu3tc9m4h7l9vgyv9l3zd58aqwnn6xz" "erd1r9j4wwjw7qxqv8ztrl7spdsjwq2lcay2cjj9hl9mg2qvnc82hs3qurz6su" 5000000000000000000000
mxpy contract call erd1qqqqqqqqqqqqqpgq4dvqaez22usynmp7e3w957q24m6740nkch9s5lvlc7 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=5000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="unpausePool" --arguments str:"MID-7f1d59" str:"WEGLD-d7c6bb" MEX-dc289c

mxpy contract call erd1qqqqqqqqqqqqqpgq4dvqaez22usynmp7e3w957q24m6740nkch9s5lvlc7 --pem="~/MultiversX/wallets/wallet.pem" --value=50000000000000000 --gas-limit=70000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="issueLpToken" --arguments str:"MID-7f1d59" str:"WEGLD-d7c6bb" str:"MIDWEGLD" str:"MIDWEGLDLP"
mxpy contract call erd1qqqqqqqqqqqqqpgq4dvqaez22usynmp7e3w957q24m6740nkch9s5lvlc7 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=70000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="setLocalRoles" --arguments str:"MID-7f1d59" str:"WEGLD-d7c6bb"
mxpy contract call erd12stex47hwg0hvx8cfvukj3y3ugs7dm0686k3wasycffexva6ch9s7tvj29 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=6000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="MultiESDTNFTTransfer" --arguments erd1qqqqqqqqqqqqqpgq4dvqaez22usynmp7e3w957q24m6740nkch9s5lvlc7 2 str:"MID-7f1d59" 0 200000000000000000000 str:"WEGLD-d7c6bb" 0 1000000000000000000  str:"addLp"


MEX-dc289c
mxpy contract call erd1qqqqqqqqqqqqqpgq4dvqaez22usynmp7e3w957q24m6740nkch9s5lvlc7 --pem="~/MultiversX/wallets/wallet.pem" --value=50000000000000000 --gas-limit=70000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="issueLpToken" --arguments str:"MID-7f1d59" str:"MEX-dc289c" str:"MIDMEX" str:"MIDMEXLP"
mxpy contract call erd1qqqqqqqqqqqqqpgq4dvqaez22usynmp7e3w957q24m6740nkch9s5lvlc7 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=70000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="setLocalRoles" --arguments str:"MID-7f1d59" str:"MEX-dc289c"
mxpy contract call erd12stex47hwg0hvx8cfvukj3y3ugs7dm0686k3wasycffexva6ch9s7tvj29 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=6000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="MultiESDTNFTTransfer" --arguments erd1qqqqqqqqqqqqqpgq4dvqaez22usynmp7e3w957q24m6740nkch9s5lvlc7 2 str:"MID-7f1d59" 0 70000000000000000000 str:"MEX-dc289c" 0 10000000000000000000  str:"addLp"


SNS-ffcb8c
mxpy contract call erd1qqqqqqqqqqqqqpgq4dvqaez22usynmp7e3w957q24m6740nkch9s5lvlc7 --pem="~/MultiversX/wallets/wallet.pem" --value=50000000000000000 --gas-limit=70000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="issueLpToken" --arguments str:"MID-7f1d59" str:"SNS-ffcb8c" str:"MIDSNS" str:"MIDSNSLP"
mxpy contract call erd1qqqqqqqqqqqqqpgq4dvqaez22usynmp7e3w957q24m6740nkch9s5lvlc7 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=70000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="setLocalRoles" --arguments str:"MID-7f1d59" str:"SNS-ffcb8c"
mxpy contract call erd12stex47hwg0hvx8cfvukj3y3ugs7dm0686k3wasycffexva6ch9s7tvj29 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=6000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="MultiESDTNFTTransfer" --arguments erd1qqqqqqqqqqqqqpgq4dvqaez22usynmp7e3w957q24m6740nkch9s5lvlc7 2 str:"MID-7f1d59" 0 10000000000000000000 str:"SNS-ffcb8c" 0 10000000000000000000  str:"addLp"


# mxpy contract upgrade erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --bytecode=output/staking-contract.wasm --gas-limit=72000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --arguments str:"MID-ecb7bf" "erd1u8nxp4kkt3jqj3uxfftklwntf4fcu3tc9m4h7l9vgyv9l3zd58aqwnn6xz" "erd1r9j4wwjw7qxqv8ztrl7spdsjwq2lcay2cjj9hl9mg2qvnc82hs3qurz6su" 5000000000000000000000
#MAINNET ! YELLOW
MEX-455c57
mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --value=50000000000000000 --gas-limit=70000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="issueLpToken" --arguments str:"MID-ecb7bf" str:"MEX-455c57" str:"MIDMEX" str:"MIDMEXLP"
mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --gas-limit=70000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="setLocalRoles" --arguments str:"MID-ecb7bf" str:"MEX-455c57"
mxpy contract call erd1h29t8znkdhz4ycc5p797qang79kxewv789c95ef7pv8wj9q55gcsa9z3l6 --ledger --ledger-address-index 0 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=6000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="MultiESDTNFTTransfer" --arguments erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 2 str:"MID-ecb7bf" 0 4000000000000000000000 str:"MEX-455c57" 0 12000000000000000000000000  str:"addLp"

VITAL-ab7917
mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --value=50000000000000000 --gas-limit=70000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="issueLpToken" --arguments str:"MID-ecb7bf" str:"VITAL-ab7917" str:"MIDVITAL" str:"MIDVITALLP"
mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --gas-limit=70000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="setLocalRoles" --arguments str:"MID-ecb7bf" str:"VITAL-ab7917"
mxpy contract call erd1h29t8znkdhz4ycc5p797qang79kxewv789c95ef7pv8wj9q55gcsa9z3l6 --ledger --ledger-address-index 0 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=6000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="MultiESDTNFTTransfer" --arguments erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 2 str:"MID-ecb7bf" 0 4000000000000000000000 str:"VITAL-ab7917" 0 5000000000000000000000000  str:"addLp"

WEGLD-bd4d79
mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --value=50000000000000000 --gas-limit=70000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="issueLpToken" --arguments str:"MID-ecb7bf" str:"WEGLD-bd4d79" str:"MIDWEGLD" str:"MIDWEGLDLP"
mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --gas-limit=70000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="setLocalRoles" --arguments str:"MID-ecb7bf" str:"WEGLD-bd4d79"
mxpy contract call erd1h29t8znkdhz4ycc5p797qang79kxewv789c95ef7pv8wj9q55gcsa9z3l6 --ledger --ledger-address-index 0 --pem="~/MultiversX/wallets/wallet.pem" --gas-limit=6000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="MultiESDTNFTTransfer" --arguments erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 2 str:"MID-ecb7bf" 0 1000000000000000000000 str:"WEGLD-bd4d79" 0 1000000000000000000  str:"addLp"

UTK INIT STAKE POOL & PAUSE #YELLOW
mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --gas-limit=10000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="setFees" --arguments str:"MID-ecb7bf" str:"UTK-2f80e9" "0" "0"
mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --gas-limit=10000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="pausePool" --arguments str:"MID-ecb7bf" str:"UTK-2f80e9"

UTK-2f80e9 LP
mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --value=50000000000000000 --gas-limit=70000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="issueLpToken" --arguments str:"MID-ecb7bf" str:"UTK-2f80e9" str:"MIDUTK" str:"MIDUTKLP"
mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --gas-limit=70000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="setLocalRoles" --arguments str:"MID-ecb7bf" str:"UTK-2f80e9"
mxpy contract call erd1h29t8znkdhz4ycc5p797qang79kxewv789c95ef7pv8wj9q55gcsa9z3l6 --ledger --ledger-address-index 0 --gas-limit=6000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="MultiESDTNFTTransfer" --arguments erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 2 str:"MID-ecb7bf" 0 450000000000000000000 str:"UTK-2f80e9" 0 200000000000000000000  str:"addLp"

XTW-78700a LP
mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --value=50000000000000000 --gas-limit=70000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="issueLpToken" --arguments str:"MID-ecb7bf" str:"XTW-78700a" str:"MIDXTW" str:"MIDXTWLP"
mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --gas-limit=70000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="setLocalRoles" --arguments str:"MID-ecb7bf" str:"XTW-78700a"
mxpy contract call erd1u8nxp4kkt3jqj3uxfftklwntf4fcu3tc9m4h7l9vgyv9l3zd58aqwnn6xz --ledger --ledger-address-index 1 --gas-limit=6000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="MultiESDTNFTTransfer" --arguments erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 2 str:"MID-ecb7bf" 0 5000000000000000000000 str:"XTW-78700a" 0 500000000000000000000000  str:"addLp"



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

# mxpy contract upgrade erd1qqqqqqqqqqqqqpgq4dvqaez22usynmp7e3w957q24m6740nkch9s5lvlc7 --pem="~/MultiversX/wallets/wallet.pem" --bytecode=output/staking-contract.wasm --gas-limit=60000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --arguments str:"MID-7f1d59" "erd1u8nxp4kkt3jqj3uxfftklwntf4fcu3tc9m4h7l9vgyv9l3zd58aqwnn6xz" "erd1r9j4wwjw7qxqv8ztrl7spdsjwq2lcay2cjj9hl9mg2qvnc82hs3qurz6su" 5000000000000000000000
# mxpy contract upgrade ?? --ledger --ledger-address-index 2 --bytecode=output/staking-contract.wasm --gas-limit=60000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --arguments str:"MID-ecb7bf" "erd1u8nxp4kkt3jqj3uxfftklwntf4fcu3tc9m4h7l9vgyv9l3zd58aqwnn6xz" "erd1r9j4wwjw7qxqv8ztrl7spdsjwq2lcay2cjj9hl9mg2qvnc82hs3qurz6su" 5000000000000000000000
# mxpy contract upgrade erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --bytecode=output/staking-contract.wasm --gas-limit=60000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --arguments str:"MID-ecb7bf" "erd1u8nxp4kkt3jqj3uxfftklwntf4fcu3tc9m4h7l9vgyv9l3zd58aqwnn6xz" "erd1r9j4wwjw7qxqv8ztrl7spdsjwq2lcay2cjj9hl9mg2qvnc82hs3qurz6su" 5000000000000000000000

#configure les frais et burn pour une pool
#FEES BURN opt:speed
# fn set_fees(&self, staked_token: TokenIdentifier, rewarded_token: TokenIdentifier, fees: u64, burn: u64, opt_blocks_to_max: OptionalValue<u64>) {

setFees() {
    mxpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${OWNER_PEM} \
    --gas-limit=10000000 \
    --function="setFees" \
    --arguments ${T_MID} ${T_MID} "400" "100"
}
# mxpy contract call ?? --ledger --ledger-address-index 2 --gas-limit=10000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="setFees" --arguments str:"MID-7f1d59" str:"MID-7f1d59" "400" "100"
# mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --gas-limit=10000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="setFees" --arguments str:"MID-ecb7bf" str:"MID-ecb7bf" "400" "100"
#SPEED 730 on MID:MEX with 0 fees
# mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --gas-limit=10000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="setFees" --arguments str:"MID-ecb7bf" str:"MEX-455c57" "0" "0" "10512000"

#YELLOW
mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --gas-limit=10000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="setFees" --arguments str:"MID-ecb7bf" str:"MID-ecb7bf" "400" "1600"

mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --gas-limit=10000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="setFees" --arguments str:"MID-ecb7bf" str:"VITAL-ab7917" "0" "0"
mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --gas-limit=10000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="setFees" --arguments str:"VITAL-ab7917" str:"VITAL-ab7917" "0" "0"
mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --gas-limit=10000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="setFees" --arguments str:"VITAL-ab7917" str:"MID-ecb7bf" "0" "0"




#Met en pause les fonction des fund et stake (allPool)
pause() {
    mxpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${OWNER_PEM} \
    --gas-limit=10000000 \
    --function="pause"
}
# mxpy contract call ?? --ledger --ledger-address-index 2 --gas-limit=5000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="pause"
# mxpy contract call erd1qqqqqqqqqqqqqpgqgdf6vk43c2jxk4a6nw2adv8vmnpqagegtxfqmf8et2 --ledger --ledger-address-index 2 --gas-limit=5000000 --recall-nonce --proxy="https://gateway.multiversx.com" --chain 1 --send --function="pause"

#fin de pause fund et stake (allPool)
unpause() {
    mxpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${OWNER_PEM} \
    --gas-limit=10000000 \
    --function="unpause"
}
# mxpy contract call ?? --ledger --ledger-address-index 2 --gas-limit=5000000 --recall-nonce --proxy="https://devnet-gateway.multiversx.com" --chain D --send --function="unpause"
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


