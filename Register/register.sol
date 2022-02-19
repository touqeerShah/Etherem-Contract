    // SPDX-License-Identifier: GPL-3.0

    pragma solidity >=0.7.0 <0.9.0;
import "./2_Owner.sol";
    /** 
    * @title Ballot
    * @dev Implements voting process along with vote delegation
    */
    contract Register is Owner {
        uint public latestVersion=0;
        mapping(uint => address) versionHistory;

    function UpdateContractVersion(address _contractAddress) public isOwner{
        latestVersion++;
        versionHistory[latestVersion]= _contractAddress;
    }
    function getLatestContactAddress() public view returns (address ref){
        return (versionHistory[latestVersion]);
    }
    function getContactByIndex( uint index) public view returns (address ref){
        return (versionHistory[index]);
    }
    }

