// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

contract Homework5{

    constructor(){}

    function assemby1() pure public returns (uint256){
        assembly {
            let result := add(0x07, 0x08)
            mstore(0x80, result) // store result in memory
            return(0x80, 32) // return 32 bytes from memory
        }
    }
}