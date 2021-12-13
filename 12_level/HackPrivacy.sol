// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

// call the unlock() function through Remix IDE with the obtained key from the storage

interface Privacy {
    function unlock(bytes16 _key) external;
}

contract HackPrivacy {
    Privacy public privacy =
        Privacy(0xC15D9B50C61d64246269315c17F95E3f8dD3446b);

    function unlock(bytes32 _key) public {
        privacy.unlock(bytes16(_key));
    }
}
