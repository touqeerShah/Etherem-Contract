// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
contract TimeBased {

    uint creationTime= block.timestamp;
    uint maxTime = creationTime + 1 minutes;
    mapping (address=> uint) balances;
    error lackOfFund();

    modifier timeRestruction(uint time){
        if(block.timestamp<time){
            revert("Time Restruction is on this function");
        }
        _;
    }

    modifier costRestruction(uint _cost){
        if(msg.value<_cost){
            revert lackOfFund();
        }else if(msg.value>_cost){
            payable(msg.sender).transfer(msg.value-_cost);   
        }
        _;
    }
    function winnerName() public view timeRestruction(maxTime) returns(string memory _winnerName){
        return "Ali";
    } 
    function winnerName2() public view timeRestruction(maxTime + 1 minutes) returns(string memory _winnerName){
        return "Ali";
    } 
    function winnerName3() public costRestruction(1 ether)  payable{
        balances[msg.sender]= 1 ether;
    } 

    function getBalance() public view returns(uint balance){
       return address(this).balance;
   }
    
    
}

