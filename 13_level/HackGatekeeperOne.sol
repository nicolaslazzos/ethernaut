// => Player address 0x0718eccf37de50e31620C658B2c96adDc1e76300
// => Ethernaut address 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33
// => Instance address 0x78cBd8b42c4e25217AEE3Db5A5862edaB9276852

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./SafeMath.sol";
import "./GatekeeperOne.sol";

contract HackGatekeeperOne {
  using SafeMath for uint256;
  GatekeeperOne public gatekeeper;

  // each hex digit takes 4 bits, so
  // bytes8 = 0xFFFFFFFFFFFFFFFF
  // uint16 = 16bits = 2bytes = 0xFFFF

  // whenever you convert a datapoint with larger storage space into a smaller one, you will lose and corrupt your data
  // example (this is how data looks in bytes, 1 means that unit is allocated)
  // bytes8 = 0x1111111111111111
  // to bytes4 = 0x11111111
  // to bytes8 = 0x0000000011111111

  // if you want to intentionally achieve the above result, you can use bytemasking
  // byte masking example
  // bytes2 a = 0xFFFF => 0x1111
  // bytes2 b = 0XF0F0 => 0x1010
  // bytes2 c = a & b  => 0x1010

  // so to solve the gate three, thats what happens
  // the first condition is basically uint32(_gateKey) == uint16(_gateKey)
  // in bytes, thats 0x11111111 == 0x1111
  // to fulfill that condition, we need the mask to be 0x0000FFFF
  // so it will be 0x00001111 == 0x1111

  // the second condition is basically uint32(_gateKey) == uint64(_gateKey)
  // in bytes, thats 0x11111111 != 0x1111111111111111
  // to fulfill that condition, we need the mask to be 0xFFFFFFFF0000FFFF
  // so it will be 0x1111111100001111 != 0x1111

  // then, to fulfill the last condition, we can get the key
  // by masking the tx.origin address with the mask we got before

  function enter(address _address, uint _gas, bytes8 _origin) public {
    gatekeeper = GatekeeperOne(_address);

    // _origin should be your address casted to bytes8 (the last 16 digits)
    bytes8 key = _origin & 0xFFFFFFFF0000FFFF; // 0xB2c96adDc1e76300
    bytes memory payload = abi.encodeWithSignature("enter(bytes8)", key);

    // the proper gas offset to use will vary depending on the compiler
    // version and optimization settings used to deploy the factory contract.
    // so we brute-force a range of possible values of gas to forward.
    // using call instead of directly calling gatekeeper.enter() prevents revert() from propagating and making the function fail.
    for (uint256 i = 0; i < 100; i++) {
      
      // the _gas should be a multiple of 8191 (eg. 819100) plus 250 in my case
      (bool result, bytes memory data) = address(gatekeeper).call{ gas: i + _gas }(payload);
      if (result) break;
      data;
    }
  }
}
