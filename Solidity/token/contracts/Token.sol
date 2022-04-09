// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";

contract ExampleToken is ERC20Capped {
    constructor() ERC20("ExampleToken", "EXMT") ERC20Capped(1000000) {
        _mint(msg.sender, 100000);
    }
}
