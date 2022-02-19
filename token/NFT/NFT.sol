// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
    /** 
    * @title Ballot
    * @dev Implements voting process along with vote delegation
    */
    import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
    import "@openzeppelin/contracts/utils/Counters.sol";

    contract NFTToken  is ERC721URIStorage{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("PAKNFT", "PK") {}
    function cookNFT(address player, string memory tokenURI)
        public
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(player, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
    }

