# DegenToken

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
/*Your task is to create a ERC20 token and deploy it on the Avalanche network for Degen Gaming.
The smart contract should have the following functionality:

1. Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. 
Only the owner can mint tokens.
2. Transferring tokens: Players should be able to transfer their tokens to others.
3. Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
4. Checking token balance: Players should be able to check their token balance at any time.
5. Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.  */


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20,Ownable,ERC20Burnable{

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender){}

     // Items name available for Loot
    enum loot{common,rare,unique,legend}

     struct Player{
     address toAddress;
     uint amount;

    }

   //The queue of player for buying degenToken 
    Player[] public players;

    struct PlayerLoot{
        
        uint common;
        uint rare;
        uint unique;
        uint legend;        
    }

    //To store the redeemed player loot cards
    mapping (address=>PlayerLoot) public playerCards;

    function buyDegen(address _toAddress,uint _amount)public{
        players.push(Player({toAddress:_toAddress,amount:_amount}));
    }

    //minting of tokens for the buyers in the queue
    function mintToken() public onlyOwner {
        //loop to mint tokens for buyers in queue
        while (players.length!=0) {
            uint i = players.length -1;
            if (players[i].toAddress != address(0)) { // Check for non-zero address
            _mint(players[i].toAddress, players[i].amount);
            players.pop();
            }
        }
    }
    
    //Transfer function for transferring tokens to other player
    function transferDegen(address _to, uint _amount)public {
        require(_amount<=balanceOf(msg.sender),"INSUFFICIENT");
        _transfer(msg.sender, _to, _amount);
    }



    //Redeem different loot cards
    function redeemyourloot( loot _card)public{
        if(_card == loot.common){
            require(balanceOf(msg.sender)>=15,"INSUFFICIENT");
            playerCards[msg.sender].common +=1;
            burn(15);
        }else if(_card == loot.rare){
            require(balanceOf(msg.sender)>=25,"Insufficient");
            playerCards[msg.sender].rare +=1;
            burn(25);
        }else if(_card == loot.unique){
            require(balanceOf(msg.sender)>=35,"INSUFFICIENT");
            playerCards[msg.sender].unique +=1;
            burn(35);
        }else if(_card == loot.legend){
            require(balanceOf(msg.sender)>=60,"INSUFFICIENT");
            playerCards[msg.sender].legend +=1;
            burn(60);
        }else{
            revert("NOT AMONGST AVAILABLE CARDS");
        }
    }

    //function to burn token
    function burnDegen(address _of, uint amount)public {
        _burn(_of, amount);
    }

    //function to check the balance of tokens
    function checkYourBalance()public view returns(uint){
        return balanceOf(msg.sender);
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
