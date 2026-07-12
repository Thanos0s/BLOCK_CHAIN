// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC20.sol";

contract TokenA is ERC20{
    constructor(uint256 initialSupply) ERC20("TokenA","TKA",initialSupply){

    }


}