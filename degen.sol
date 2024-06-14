/*
Challenge
Your task is to create a ERC20 token and deploy it on the Avalanche network for Degen Gaming. The smart contract should have the following functionality:

1. Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
2. Transferring tokens: Players should be able to transfer their tokens to others.
3. Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
4. Checking token balance: Players should be able to check their token balance at any time.
5. Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.
*/
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    
    uint256 public constant EXCHANGE_RATE = 100;

    mapping(address => uint256) public shieldsOwned;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        _mint(msg.sender, 10 * (10 ** uint256(decimals())));
    }

    function exchangeShield(uint256 amount) public {
        uint256 totalCost = EXCHANGE_RATE * amount;
        require(balanceOf(msg.sender) >= totalCost, "Insufficient tokens to exchange for a shield");

        shieldsOwned[msg.sender] += amount;
        _burn(msg.sender, totalCost);
    }

    function viewShieldsOwned(address holder) public view returns (uint256) {
        return shieldsOwned[holder];
    }

    function generateTokens(address recipient, uint256 quantity) public onlyOwner {
        _mint(recipient, quantity);
    }

    function viewBalance(address holder) public view returns (uint256) {
        return balanceOf(holder);
    }

    function destroyTokens(uint256 quantity) public {
        require(balanceOf(msg.sender) >= quantity, "Insufficient tokens to burn");
        _burn(msg.sender, quantity);
    }

    function transferHoldings(address recipient, uint256 quantity) public {
        require(recipient != address(0), "Invalid recipient address");
        require(balanceOf(msg.sender) >= quantity, "Insufficient tokens to transfer");
        _transfer(msg.sender, recipient, quantity);
    }
}
