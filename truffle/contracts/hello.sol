// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract HelloWorld {
    uint age;
    string name;

    function setName( string memory _name) public{
        name=_name; 
    }
}