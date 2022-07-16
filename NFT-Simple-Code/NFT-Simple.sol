//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("PHRAMATRACR-NFT", "PHRAMATRACR") {}

    function mintNFT(address recipient, string memory tokenURI)
        public
        onlyOwner
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}
// Reference Link
// https://ethereum.org/ca/developers/tutorials/how-to-write-and-deploy-an-nft/
// ipfs://QmXvcW5CdZBxktQta5n7cbPSz1vb3cX3j3sDZTJFFdM8VQ/conveyor
// gateway.pinata.cloud/ipfs/QmXvcW5CdZBxktQta5n7cbPSz1vb3cX3j3sDZTJFFdM8VQ/contract
