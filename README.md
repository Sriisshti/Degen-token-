#DegenToken

Simple Overview
DegenToken is an ERC20 token deployed on the Avalanche network for Degen Gaming. This token facilitates in-game rewards, item exchanges, and token management for players.

## Description

DegenToken is a custom ERC20 token created for Degen Gaming on the Avalanche network. The smart contract allows for minting, transferring, redeeming, checking balances, and burning tokens. Only the owner can mint new tokens, ensuring controlled distribution for rewards. Players can exchange tokens for in-game items, transfer tokens to other players, and manage their token balances. The contract also provides a method for burning tokens that are no longer needed.

## Getting Started

### Installing

To run this program, you will need to use Remix, an online Solidity IDE. Follow these steps to get started:

Visit Remix: Go to https://remix.ethereum.org/.
Create a New File: Click on the "+" icon in the left-hand sidebar to create a new file.
Save the File: Save the file with a .sol extension (e.g., degen.sol).
Copy and Paste Code: Copy and paste the following code into the new file:

### Executing program

To run the program, follow these steps:

Compile the Code:

Click on the "Solidity Compiler" tab in the left-hand sidebar.
Ensure the "Compiler" option is set to a compatible version, such as "0.8.23".
Click on the "Compile Degen.sol" button.
Deploy the Contract:

Click on the "Deploy & Run Transactions" tab in the left-hand sidebar.
Select the "Degen" contract from the dropdown menu.
Click on the "Deploy" button.
Interact with the Contract:

Minting Tokens: Upon deployment, 10 DGN tokens are minted to the contract address.
Creating Tokens: Call the createTokens function.
Destroying Tokens: Call the destroyTokens function with the amount to burn tokens .
```
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

```

## Help

Common Issues:

Insufficient Tokens for Exchange or Transfer:
Ensure you have enough tokens in your balance before performing exchange or transfer operations. Use viewBalance to check your balance.

Invalid Recipient Address:
When transferring tokens, make sure the recipient address is valid and not the zero address.
## Authors

Srishti
@Srishti

## License

This project is licensed under the License - see the LICENSE.md file for details
