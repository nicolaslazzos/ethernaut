// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0xae28980f4749CB1e9845381ed2d4DB9a62535E3A

// solution

// easy way, seach the Recovery contract address in etherscan and look up for the
// SimpleToken contract creation, then you have the address, so using Remix, create
// an instance of the SimpleToken contract at that address and call the destroy() function with your address

// other way, recalculate the SipleToken address, using the Recovery contract address
// contract addresses are deterministic and are calculated by keccack256(address, nonce),
// where the address is the address of the contract (or ethereum address that created the transaction)
// and nonce is the number of contracts the spawning contract has created (or the transaction nonce, for regular transactions)
// the address will be the rightmost first 20 bytes (see in the documentation)

// how to do it using web3
// where the first 2 parameters are the RLP encoding of a 20-byte address
// the second is the Recovery contract address
// and the last is the nonce, is 1 because the Recovery contract only created one
web3.utils.soliditySha3("0xd6", "0x94", "0xae28980f4749CB1e9845381ed2d4DB9a62535E3A", "0x01");

// result = '0xa8401180e4a3a1c43718a6a04ddfeb58fc63fe2d74d29f750f53ae21a8aa5048'

// address = '4ddfeb58fc63fe2d74d29f750f53ae21a8aa5048' // (20 rightmost bytes)