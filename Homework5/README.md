# Homework 5    
## Assembly 1
1. Look at the example of init code in today's notes See [Deployer.sol](https://github.com/tikisailor/expert-solidity-bootcamp/tree/main/Homework5/Deployer.sol). When we do the `CODECOPY` operation, what are we overwriting?
(debugging this in Remix might help here)     
     
    --> We are overwriting the free memory pointer which has been set up by the init code.    
     
2. Could the answer to Q1 allow an optimisation?     
    
    --> Yes, we could optimize it by not creating the free memory pointer as it serves no purpose in this case.    
      
3. Can you trigger a revert in the init code in Remix?     
     
    --> Yes, by seding some wei in the deployment tx    
     
4. Write some Yul to
    1. Add 0x07 to 0x08
    2. store the result at the next free memory location.     
    [solution](https://github.com/tikisailor/expert-solidity-bootcamp/tree/main/Homework5/homework5.sol)     
    ```
    assembly {
            let result := add(0x07, 0x08)
            mstore(0x80, result) // store result in memory
            return(0x80, 32) // return 32 bytes from memory
    }
    ```
    3. (optional) write this again in opcodes   
    ```
    PUSH2 0x07 0x08
    ADD
    PUSH1 0x80
    MSTORE
    RETURN 0x80 0x20
    ```  

5. Can you think of a situation where the opcode EXTCODECOPY is used?     
    --> to check and compare a contract's bytecode    
    --> to use a deployed contract as the "storage" of another contract    

6. Complete the assembly [exercises](https://github.com/tikisailor/expert-solidity-bootcamp/tree/main/Homework5/AssemblyExercises)     