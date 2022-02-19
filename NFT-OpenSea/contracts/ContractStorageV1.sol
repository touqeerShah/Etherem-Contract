// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
    /** 
    * @title Ballot
    * @dev Implements voting process along with vote delegation
    */
    contract ContractStorageV1 {
       
       mapping(bytes32 => uint) uintVaraibale;
       mapping(bytes32 => string) stringVaraibale;
    function setUintVar(bytes32 var_name, uint var_value) public {
        uintVaraibale[var_name]= var_value;
    }
    function getUintVar(bytes32 var_name) public view returns(uint val){
        return uintVaraibale[var_name];
    }


    function setStringVar (bytes32 var_name, string calldata var_value) public {
        stringVaraibale[var_name]= var_value;
    }
    function getStringVar(bytes32 var_name) public view returns(string memory val){
        return stringVaraibale[var_name];
    }
    }

library ContractLib{

    function setUintValue( address _contractStorage,string calldata var_name, uint var_value) public{
        ContractStorageV1(_contractStorage).setUintVar(keccak256(bytes (var_name)), var_value);
    }
    function getUintValue( address _contractStorage,string calldata var_name) public view returns(uint){
        return  ContractStorageV1(_contractStorage).getUintVar(keccak256(bytes (var_name)));
    }



    function setStringValue( address _contractStorage,string calldata var_name, string calldata var_value) public{
        ContractStorageV1(_contractStorage).setStringVar(keccak256(bytes (var_name)), var_value);
    }
    function getStringValue( address _contractStorage,string memory var_name) public view returns(string memory){
        return  ContractStorageV1(_contractStorage).getStringVar(keccak256(bytes (var_name)));
    }
}
