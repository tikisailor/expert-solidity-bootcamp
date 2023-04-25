## Questions

# 1. Why is client diversity important for Ethereum   
-Client diversity is important for Ethereum because it helps to improve the overall security and decentralization of the network. When multiple clients are used to interact with the Ethereum network, it reduces the risk of a single point of failure and makes it more difficult for any one group or individual to exert control over the network. Additionally, client diversity helps to ensure that the network remains resilient to bugs or vulnerabilities that may be present in any one client implementation.

# 2. Where is the full Ethereum state held ?   
-The full Ethereum state is held by every node on the network. This means that each node maintains a complete copy of the blockchain, including all transactions and smart contracts that have been executed on the network (configurable up to an extent i.e. pruning).

# 3. What is a replay attack ? , which 2 pieces of information can prevent it ?   
-A replay attack is a type of attack where an attacker intercepts and replays a transaction that has already been broadcast to the network. This can result in unintended or malicious actions being performed on the network. Two pieces of information that can prevent a replay attack are a unique identifier for each transaction (such as a nonce) and the inclusion of the chain ID in transaction data (to avoid replay on another chain).

# 4. In a contract, how do we know who called a view function ?  
-It is not possible to know who called a view function. View functions are read-only functions that do not modify the state of the contract, and therefore do not require a transaction to be executed. Because view functions do not result in a transaction being broadcast to the network, there is no way to determine who called the function.
