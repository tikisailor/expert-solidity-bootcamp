// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Question2 {

    bytes32 eventSigHash = keccak256(abi.encodePacked('transferOccurred(address,uint256)'));

    function checkCall(bytes calldata data) external{

        assembly {
            function selector() -> s {
                s := div(calldataload(0), 0x100000000000000000000000000000000000000000000000000000000)
            }

            function payloadSelector() -> s {
                s := div(decodeAsUint(2), 0x100000000000000000000000000000000000000000000000000000000)
            }

            function decodeAsUint(offset) -> v {
                let pos := add(4, mul(offset, 0x20))
                if lt(calldatasize(), add(pos, 0x20)) {
                    revert(0, 0)
                }
                v := calldataload(pos)
            }

            switch selector()
            case 0x80f394b8 /* "checkCall(bytes calldata data)" */ {
                switch payloadSelector()
                case 0xa9059cbb /* "transfer(address,uint256)" */ {
                    let s := decodeAsUint(2)
                    let _address := calldataload(add(8, mul(2, 0x20))) // offset of 8 because we have 2 fn signatures
                    let _amount := calldataload(add(8, mul(3, 0x20)))
                    mstore(0x100, _address)
                    mstore(0x120, _amount)
                    let signatureHash := sload(eventSigHash.slot)
                    log1(0x100, 0x40, signatureHash)
                }
                default {
                    revert(0, 0)
                }
            }
            
        }
    }
}