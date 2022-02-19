// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
contract callfallback {
    uint public x ;
    uint public y;
    event fallbackcalled(string );

    function withdraw() public returns(string memory ref) {
     x++;
     return "test";
    }
       function getBalance() public view returns(uint balance){
       return address(this).balance;
   }


    fallback() payable  external{
        y++;
       emit fallbackcalled("Non existing Function called");
    }


}

