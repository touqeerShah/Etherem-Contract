// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
contract FundTransfer {
   mapping (address => uint) fund;

   function getBalance() public view returns(uint balance){
       return address(this).balance;
   }

   function addFund() public payable {
       fund[msg.sender]= msg.value;
   }
   function withDraw()public{
    uint amount = fund[msg.sender];
    fund[msg.sender]=0;
    payable(msg.sender).transfer(amount);   
   }
}

