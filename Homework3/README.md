# Homework 3

## EVM1
### 1. What are the advantages and disadvantages of the 256 bit word length in the EVM   
    
#### Advantages:   
Large Data Representation: With a 256-bit word length, the EVM can represent much larger values than traditional 32-bit or 64-bit systems. This makes it possible to represent large numbers and addresses. It allows for high precision calculations, which is important for performing accurate financial calculations. It also provides the ability to pack address and value into a single storage index as an optimization. In comparison to unlimted word size as in Bitcoin, it makes it possible to build a secure gas model.

#### Disadvantages   
Increased Memory Usage: Because each word is 256 bits long, the EVM requires more memory to store the same amount of data compared to systems with smaller word lengths. This can lead to higher storage costs.

### 2. What would happen if the implementation of a precompiled contract varied between Ethereum clients ?   
#### Inconsistency in Results:    
If the implementation of a precompiled contract varies between Ethereum clients, it could produce different results for the same input data. This could lead to inconsistencies in the state of the blockchain, which would undermine the integrity of the network.

#### Forking:    
If some clients use one implementation of the precompiled contract, and others use a different implementation, it could lead to a fork in the blockchain. This would create two separate versions of the blockchain, which would be incompatible with each other.

#### Security Vulnerabilities:    
If one implementation of the precompiled contract is vulnerable to attacks, but another implementation is not, it could lead to security vulnerabilities in the network. Hackers could exploit the vulnerability in one implementation to steal funds or cause other types of damage.


### 3. Using Remix write a simple contract that uses a memory variable, then using the debugger step through the function and inspect the memory.
