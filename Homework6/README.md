# Homework 6   
## Assembly 2
1. Create a Solidity contract with one function. The solidity function should return the amount of ETH that was passed to it, and the
function body should be written in assembly     
     
    --> [solution](https://github.com/tikisailor/expert-solidity-bootcamp/tree/main/Homework6/EthAmount.sol)     
     
2. Do you know what this code is doing?    
    
```
push9 0x601e8060093d393df3 // Pushes init code on stack (9 bytes)
msize                      // Push size of active memory on stack
mstore                     // Store init code at offset msize -> mem = 000...000 601e8060093d393df3

# copy the runtime bytecode after the constructor code in mem
codesize                   // Get size of contract code
returndatasize             // 0
msize                      // 0x20
codecopy                   // destinationOffset (0x20), offset (0), size (codesize) 
                           // -> copy contract code to free memory right after inti code

push1 9                    // Push 9 on stack (=bytes of init code)
codesize                   // bytes of contract code
add                        // add init code length and contract code length = total code length
push1 23                   // 23 is where init code starts (contract code starts at 0x20=32, 32-9 = 23)
returndatasize             // 0, stack: 0 23 CS
dup3                       // stack: CS 0 23 CS
dup3                       // stack: 23 CS 0 23 CS
callvalue                  // stack: v 23 CS 0 23 CS
create                     // creates contract at address1 with contract account balance of callvalue, stack: addr1 0 23 CS
pop                        // stack: 0 23 CS
create                     // creates contract at address2 with contract account balance of 0, stack: addr2
selfdestruct               // halt execution
```    

--> It is creating copies of itself including initializer. It would cause it to continue until it runs out of gas.
      
3. Explain what the following code is doing in the [Yul ERC20 contract](https://docs.soliditylang.org/en/v0.8.15/yul.html#complete-erc20-example)  
```
function allowanceStorageOffset(account, spender) -> offset {
offset := accountToStorageOffset(account)
mstore(0, offset)
mstore(0x20, spender)
offset := keccak256(0, 0x40)
}
```   
--> It creates a unique storage location used to store spending allowance for account&spender at keccak256(account+0x1000, spender)