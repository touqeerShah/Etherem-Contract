// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "./callfallback.sol";
import "./testRecevied.sol";
/** 
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
contract testfallback {
    bool public data;
    constructor()  payable
        {
           
    }
    function callme(callfallback _callfallback ) public  {
    
       (data,)= address(_callfallback).call(abi.encodeWithSignature("withdraw()"));
    }

    function callme2(callfallback _callfallback ) public  {
    
       (data,)= address(_callfallback).call(abi.encodeWithSignature("deposit()"));
    }


    function sendEther(callfallback _callfallback ) public  {
    
       (data,)= address(_callfallback).call{value:1 ether }(abi.encodeWithSignature("deposit()"));
    }
    function sendEtherWithOutFunction(callfallback _callfallback ) public  {
    
       (data,)= address(_callfallback).call{value:1 ether }("");
    }

    /// call Recevide

    function sendEtherReceivedSend(testRecevied _testRecevied ) public  {
    
       data= payable(address (_testRecevied)).send(1 ether);
    }

    function sendEtherReceivedCall(testRecevied _testRecevied ) public  {
    
       (data,)= address (_testRecevied).call{value:1 ether }("");
    }

           function getBalance() public view returns(uint balance){
       return address(this).balance;
   }



}

