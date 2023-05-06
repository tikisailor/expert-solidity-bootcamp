// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.19 <0.9.0;

import { PRBTest } from "@prb/test/PRBTest.sol";
import { console2 } from "forge-std/console2.sol";
import { StdCheats } from "forge-std/StdCheats.sol";
import { Question1 } from "src/Question1.sol";
import { Question2 } from "src/Question2.sol";
import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import { ExpectEmit } from "forge-std/Test.sol";


interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address receiver, uint256 amount) external returns (bool);
}

contract Homework7Test is PRBTest, StdCheats {

    event transferOccurred(address,uint256);

    /// @dev An optional function invoked before each test case is run.
    function setUp() public virtual {
        // solhint-disable-previous-line no-empty-blocks
    }

    function test_Question1() external {
        console2.log("Testing Q1");

        // constants
        address usdc = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
        address holder = 0x7713974908Be4BEd47172370115e8b1219F4A5f0;
        address receiver = 0x3243Ed9fdCDE2345890DDEAf6b083CA4cF0F68f2;
        uint256 amount = 200000000000;

        // Fork mainnet
        vm.createSelectFork({ urlOrAlias: "mainnet", blockNumber: 16_428_000 });

        // Instantiate Question1 contract
        Question1 q1 = new Question1();

        // Impersonate holder
        vm.prank(holder);

        // Transfer to q1
        IERC20(usdc).transfer(address(q1), amount);

        // Receiver has no usdc before q1.quey call
        assertEq(IERC20(usdc).balanceOf(receiver), 0);

        // Check that q1.query is called with correct params
        vm.expectCall(
            address(q1), abi.encodeCall(q1.query, (amount, receiver, IERC20(usdc).transfer))
        );

        // Call query function
        q1.query(200000000000, receiver, IERC20(usdc).transfer);

        // Receiver has amount usdc
        assertEq(IERC20(usdc).balanceOf(receiver), amount);

    }

    function test_revertsQuestion1() external {
        console2.log("Testing Q1");

        // constants
        address usdc = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
        address receiver = 0x3243Ed9fdCDE2345890DDEAf6b083CA4cF0F68f2;

        // Fork mainnet
        vm.createSelectFork({ urlOrAlias: "mainnet", blockNumber: 16_428_000 });

        // Instantiate Question1 contract
        Question1 q1 = new Question1();

        vm.expectRevert();

        // Call query function
        q1.query(200000000000, receiver, IERC20(usdc).transfer);

        // Receiver has amount usdc
        // assertEq(IERC20(usdc).balanceOf(receiver), amount);

    }

    function test_Question2() external {
        console2.log("Testing Q2");

        address receiver = 0x3243Ed9fdCDE2345890DDEAf6b083CA4cF0F68f2;
        uint256 amount = 200000000000;

        // Instantiate Question1 contract
        Question2 q2 = new Question2();

        // Encode calldata
        bytes memory transferPayload = abi.encodeWithSignature("transfer(address,uint256)", receiver, amount);
        // bytes4(keccak256("transfer(address,uint256)")) 0xa9059cbb
        // bytes memory transferPayload = abi.encodeWithSelector(bytes4(0xa9059cbb), receiver, amount);

        // Contract call
        vm.expectEmit(false, false, false, true);
        q2.checkCall(transferPayload);
        emit transferOccurred(receiver,amount);
    }
}
