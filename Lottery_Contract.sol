 //To create a lottery smart contract.In this we will have two entities->
 //Manager - It will deploy the smart contract.
 //Players - These will participate in the lottery.
 //In order to participate in the lottery the players must exactly pay 0.1 ether to the contract balance. 
 //The lottery winner will be picked randomly by the manger only.
 //And whosoever be the winner. The entire contract balance ether will be transferred to the winner's account. 
 
 //Please Raise issue to improve the contract to implement and deploy the contract with full functionality asked in readme file.

//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

contract Lottery{
    //manager is in charge of the contract 
    address public manager;
    //new player in the contract using array[] to unlimit number 
    address[] public players;

    function lottery() public {
        manager = msg.sender;
    }
    //to call the enter function we add them to players
    function enter() public payable{
        //each player is compelled to add a certain ETH to join
        require(msg.value > .01 ether);
        players.push(msg.sender);
    }
    //creates a random hash that will become our winner
    function random() private view returns(uint){
        return  uint (keccak256(abi.encode(block.timestamp,  players)));
    }
    function pickWinner() public restricted{
        //only the manager can pickWinner
        //require(msg.sender == manager);
        //creates index that is gotten from func random % play.len
        uint index = random() % players.length;
        //pays the winner picked randomly(not fully random)
        payable (players[index]).transfer(address(this).balance);
        //empies the old lottery and starts new one
        players = new address[](0);
    }

    modifier restricted(){
        require(msg.sender == manager);
        _;

    }
}
