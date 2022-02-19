// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
    /** 
    * @title Ballot
    * @dev Implements voting process along with vote delegation
    */
    contract ContractABC {
        uint public x;
    
    function add(uint a, uint b) public {
        x = a+b;
    }
    function mul(uint a) public {
        x = x*a;
    }
    }

