# Homework 4

## CTF
Register on the Encode CTF : https://www.solidityctf.xyz/

## Optimising Storage
Take [Storage.sol](https://github.com/tikisailor/expert-solidity-bootcamp/tree/main/Homework4/Storage.sol). Use the sol2uml tool to find out how many storage slots it is using. By re ordering the variables, can you reduce the number of storage slots needed?
- [Storage.sol](https://github.com/tikisailor/expert-solidity-bootcamp/tree/main/Homework4/Storage.sol) storage [usage](https://github.com/tikisailor/expert-solidity-bootcamp/tree/main/Homework4/Store.svg) is 60 slots.
- [StorageOptimized.sol](https://github.com/tikisailor/expert-solidity-bootcamp/tree/main/Homework4/StorageOptimized.sol) storage [usage](https://github.com/tikisailor/expert-solidity-bootcamp/tree/main/Homework4/StoreOptimized.svg) is 43 slots.

## Foundry Introduction
1. Install Foundry
2. Create a project
    - 1. Use `forge init <project_name>` for the default template or
    - 2. Use this [template](https://github.com/PaulRBerg/foundry-template)
3. Run the tests supplied to familiarise yourself with Foundry    
     
[foundryProject](https://github.com/tikisailor/expert-solidity-bootcamp/tree/main/Homework4/foundryProject) - run:     
`pnpm install`     
`forge test --gas-report`

## Try out the Solidity Template or the Foundry Template
1. Start a new project using the Template    
[foundryProject](https://github.com/tikisailor/expert-solidity-bootcamp/tree/main/Homework4/foundryProject)    
2. Make a fork of mainnet from the command line (you may need to setup an Infura or Alchemy account)    
`anvil --fork-url https://mainnet.infura.io/v3/$INFURA_KEY`     
3. Query the mainnet using the command line to retrieve a property such as latest block number.      
```
$ cast chain-id
$ 1
```     
```
$ cast client
$ anvil/v0.1.0
```     
```
$ cast block-number
$ 17165326
```     
```
$ cast call $DAI \
>   "balanceOf(address)(uint256)" \
>   $LUCKY_USER
$ 16019819017478535039600351
```     
```
$ cast rpc anvil_impersonateAccount $LUCKY_USER
$ null
```      

## Is [function a](https://github.com/tikisailor/expert-solidity-bootcamp/tree/main/Homework4/foundryProject/src/ValidSolidity.sol) valid solidity?     
--> Yes. See `testValidSolidity()` [here](https://github.com/tikisailor/expert-solidity-bootcamp/tree/main/Homework4/foundryProject/test/Foo.t.sol).
