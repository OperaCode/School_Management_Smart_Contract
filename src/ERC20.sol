// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SchoolToken is ERC20, Ownable{
    constructor (uint256 initialsupply) ERC20("SchoolToken", "STKN") Ownable(msg.sender){
        _mint(msg.sender, initialsupply);
    }

// to mint more later on
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

}