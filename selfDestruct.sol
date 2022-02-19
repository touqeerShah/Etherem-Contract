// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
contract selfDestruct {
    address owner;
 mapping (address => uint) fund;

 constructor() 
        {
            owner = msg.sender;
    }
      modifier is_ECAdmin(){
        require(msg.sender==owner,"You did not Allow to Access ");
        _;
    }

   function getBalance() public view returns(uint balance){
       return address(this).balance;
   }

   function addFund() public payable {
       fund[msg.sender]= msg.value;
   }

    function killContract() public is_ECAdmin{
        selfdestruct(payable(owner));
    }

}

