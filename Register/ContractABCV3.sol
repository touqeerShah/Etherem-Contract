// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
import "./ContractStorage.sol";
    /** 
    * @title Ballot
    * @dev Implements voting process along with vote delegation
    */
    contract ContractABC {

        // uint public x;
        using ContractLib for address;
        address ContractData;
    constructor(address _contractData){
            ContractData= _contractData;
    }
    function add(uint a, uint b) public {
        uint x = a+b;
        ContractData.setUintValue("x",x);
    }

    function getX() public view returns(uint ) {
        
        return ContractData.getUintValue("x");
    }
    
  
    }

