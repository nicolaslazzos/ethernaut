// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0xe7069A71137B984640A6eF33620FE827c30Ddbae

// solution

// we will create a contract that returns the number 42, using opcodes (assembly)

/* 
useful material

https://medium.com/@blockchain101/solidity-bytecode-and-opcode-basics-672e9b1a88c2
https://blog.openzeppelin.com/deconstructing-a-solidity-contract-part-i-introduction-832efd2d7737/
*/

/*
runtime opcodes (contract execution logic)

store the value 42 with mstore(p, v) with p=pointer and v=value
- 602a => PUSH1 0x2a (push the value 42 to the stack, which is 0x2a in hexadecimal)
- 6080 => PUSH1 0x80 (select memory slot 0x80 arbitrarily to store the value)
- 52 => MSTORE (store at 0x80 the value 0x2a)

return the value 0x2a with return(p, s) with p=pointer and s=size
- 6020 => PUSH1 0x20 (set the value size, which es 32 bytes, 0x20 in hexadecimal)
- 6080 => PUSH1 0X80 (select the memory slot where the value is located)
- f3 => RETURN (returns the value at 0x80 of size 0x20)

resulting opcode: 602a60805260206080f3 (10 opcodes => 10 bytes long)
*/

/*
initialization opcodes (contract creation logic)

these opcodes need to replicate your runtime opcodes to memory, before returning them to the EVM

first lets copy the runtime opcodes into memory with codecopy(d, p, s) with d=destination position, p=position of the code and s=size of the code
- 600a => PUSH1 0x0a (the size of the runtime opcodes, 10 bytes, which is 0x0a in hexadecimal)
- 600c => PUSH1 0x0c (the position of the runtime code, which is right after the end of the initialization code, that takes 12 bytes, so it will be 0x0c, which is 13 in hexadecimal)
- 6000 => PUSH1 0x00 (select memory slot 0x00 arbitrarily as destination memory slot for the runtime code)
- 39 => CODECOPY (copy the runtime code of size 0x0a, from position 0x0c to memory slot 0x00)

then return the in-memory runtime opcodes
- 600a => PUSH1 0x0a (set the runtime opcodes size, which es 10 bytes, 0x0a in hexadecimal)
- 6000 => PUSH1 0x00 (select the memory slot where the runtime code is located)
- f3 => RETURN (returns the runtime opcodes at 0x80 of size 0x20)

resulting opcode: 0x600a600c600039600a6000f3

final sequence (initialization + runtime): 0x600a600c600039600a6000f3602a60805260206080f3
*/

const Web3 = require('web3');
const HDWalletProvider = require('truffle-hdwallet-provider');
const { rinkeby, mnemonic } = require('./env');

async function solution() {
  let provider = new Web3.providers.HttpProvider(rinkeby);
  provider = new HDWalletProvider(mnemonic, provider);

  const web3 = new Web3(provider);

  const accounts = await web3.eth.getAccounts();
  const account = accounts[0];

  const bytecode = "0x600a600c600039600a6000f3602a60805260206080f3";

  web3.eth.sendTransaction({ from: account, data: bytecode }, function (err, tx) {
    console.log('transaction:', tx);

    web3.eth.getTransactionReceipt(tx, function (err, res) {
      console.log('receipt:', res);
      process.exit();

      // if res=null, search the tx in the rinkeby etherscan and look up for the created contract address and call
      // await contract.setSolver('0x1EC9A40630F7012D6A36D6576D6d5a284dA65A92')
    });
  });

}

solution();


