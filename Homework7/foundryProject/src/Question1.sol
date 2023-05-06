// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Question1 {

    function query(uint _amount, address _receiver, function (address, uint256) external returns (bool) _tx) public returns(bool){
        bool result = _tx(_receiver, _amount);
        return result;
        // require(_tx(_receiver, _amount), 'transfer failed');
    }
}