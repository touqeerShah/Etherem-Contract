//SPDX-License-Identifier: Unlicense
//give the contract SVG code
//Output will be the NFT of that SVG
//Store that NFT MateData on Chain

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol"; //contract is simple counter countrat to create NFT ID but it implemete on library and storage classs so data will not lose
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
import "./helperContract.sol";
import "./ContractStorage.sol";

contract test is ERC721URIStorage, VRFConsumerBase, helperContract {
     using ContractLib for address;
    address ContractData;
    //event
    constructor(
        address _VRFCoordinator,
        address _LinkToken,
                address _contractData

    )
        VRFConsumerBase(_VRFCoordinator, _LinkToken)
        ERC721("SVG RANDOM NTF Token ", "TKRNDSVGNFT")
    {
                ContractData = _contractData;
        // ContractData.setUintValue("fees", 1);

    }

 function add() public {
        // uint x = a+b;
        ContractData.setUintValue("x",1);
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomness)
        internal
        override
    {
        
    }

}
