// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract DeleteArrayItems {

    uint[] myArray = [0,1,2,3,4,5,6,7,8,9,10,11];


    // More gas efficient but does not preserve order
   function deleteItem(uint index) public {

        require (index < myArray.length, 'Index has to be within Array');

        // Overwrite index to be deleted with value of last element
        myArray[index] = myArray[myArray.length - 1];

        // Remove the last element (since it is now a duplicate)
        myArray.pop();
    }

    // Less gas efficient but does preserve order
    function deleteItemSorted(uint index) public {

        require (index < myArray.length, 'Index has to be within Array');

        // move all elements down one index, starting at index to be deleted
        for (uint i = index; i < myArray.length - 1; i++) {
            myArray[i] = myArray[i + 1];
        }

        // Remove the last element (since it is now a duplicate)
        myArray.pop();
    }


    function viewItem(uint index) public view returns(uint) {

        require (index < myArray.length, 'Index has to be within Array');

        // View element at index position
        return myArray[index];
    }

    function arrayLength() public view returns(uint) {

        // View element at index position
        return myArray.length;
    }

}
