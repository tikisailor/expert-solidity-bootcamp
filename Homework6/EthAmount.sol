// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract EthValue {
    function returnWei() external payable returns (uint256) {
        assembly {
            mstore(0x80, callvalue()) 
            return(0x80, 32) 
        }
    }
}