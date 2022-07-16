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

contract RandomSVGNFT is ERC721URIStorage, VRFConsumerBase, helperContract {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string[] public temp;
    using ContractLib for address;
    address ContractData;
    //event
    event CreateSVGNFT(uint256 index, string tokenURI);
    event requestedRandomSVD(
        bytes32 indexed requestId,
        uint256 indexed tokenId
    );
    event createUniFinishedRandomSVD(
        uint256 indexed tokenId,
        uint256 indexed randomNumber
    );

    constructor(
        address _VRFCoordinator,
        address _LinkToken,
        bytes32 _keyHash,
        uint256 _fees,
        address _contractData
    )
        VRFConsumerBase(_VRFCoordinator, _LinkToken)
        ERC721("SVG RANDOM NTF Token ", "TKRNDSVGNFT")
    {
        ContractData = _contractData;
        ContractData.setUintValue("fees", _fees);
        ContractData.setBytes32Value("keyHash", _keyHash);
        ContractData.setUintValue("maxNumberPath", 10);
        ContractData.setUintValue("maxNumberPathCammand", 5);
        ContractData.setUintValue("size", 500);
        temp = ["M", "L"];
        ContractData.setStringArrayValue("pathCammand", temp);
        temp = ["red", "yello", "green", "blue"];
        ContractData.setStringArrayValue("colour", temp);
    }

    function createNFT() public returns (bytes32 requestId) {
        requestId = requestRandomness(
            ContractData.getBytes32Value("keyHash"),
            ContractData.getUintValue("fees")
        );
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        ContractData.setUintWithBytes32NameValue(requestId, newItemId);
        ContractData.setRequestIdToStringValue(requestId, msg.sender);
        emit requestedRandomSVD(requestId, newItemId);
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomness)
        internal
        override
    {
        address ownerNFT = ContractData.getRequestIdToStringValue(requestId);
        uint256 tokenId = ContractData.getUintWithBytes32NameValue(requestId);
        _safeMint(ownerNFT, tokenId);
        ContractData.setTokenIdToRandomNumberValue(tokenId, randomness);
        emit createUniFinishedRandomSVD(tokenId, randomness);
    }

    function finishMint(uint256 tokenId) public {
        require(
            bytes(tokenURI(tokenId)).length <= 0,
            "token URI already all set"
        );
        uint256 tokenCount = _tokenIds.current();

        require(tokenCount > tokenId, "token did not minted yet");
        require(
            ContractData.getTokenIdToRandomNumberValue(tokenId) > 0,
            "need to wait for Chainlink VRF"
        );

        uint256 randomNumber = ContractData.getTokenIdToRandomNumberValue(
            tokenId
        );
        string memory svg = generateSVG(randomNumber);
        string memory imageURI = svgToImageURI(svg);
        string memory NFTName = string(
            abi.encodePacked("TK-RAN-NFT-", toString(tokenId))
        );
        string memory tokenURI = formatTokenURI(NFTName, imageURI);

        _setTokenURI(tokenId, tokenURI);
        emit CreateSVGNFT(tokenId, tokenURI);
    }

    function generateSVG(uint256 randomNumber)
        public
        view
        returns (string memory finalSVG)
    {
        uint256 numberOfPath = (randomNumber %
            ContractData.getUintValue("maxNumberPath")) + 1;

        finalSVG = string(
            abi.encodePacked(
                "<svg xmlns='http://www.w3.org/2000/svg' height='",
                toString(ContractData.getUintValue("size")),
                "'width='",
                toString(ContractData.getUintValue("size")),
                "'>"
            )
        );
        for (uint256 index = 0; index < numberOfPath; index++) {
            uint256 newRAN = uint256(
                keccak256(abi.encode(randomNumber, index))
            );
            string memory pathSVG = generatePath(newRAN);
            finalSVG = string(abi.encodePacked(finalSVG, pathSVG));
        }

        finalSVG = string(abi.encodePacked(finalSVG, "</svg>"));
    }

    function generatePath(uint256 randomNumber)
        public
        view
        returns (string memory pathSVG)
    {
        uint256 numberOfPathCommands = (randomNumber %
            ContractData.getUintValue("maxNumberPathCammand")) + 1;
        pathSVG = " <path d='";
        for (uint256 index = 0; index < numberOfPathCommands; index++) {
            uint256 newRAN = uint256(
                keccak256(abi.encode(randomNumber, index))
            );
            string memory pathCommand = generatePathCammand(newRAN);
            pathSVG = string(abi.encodePacked(pathSVG, pathCommand));
        }
        string[] memory colors = ContractData.getStringArrayValue("colour");
        string memory color = colors[randomNumber % colors.length];
        pathSVG = string(abi.encodePacked(pathSVG, "'stroke='", color, "' />"));
    }

    function generatePathCammand(uint256 randomNumber)
        public
        view
        returns (string memory pathCommand)
    {
        string[] memory pathCammandArray = ContractData.getStringArrayValue(
            "pathCammand"
        );
        pathCommand = pathCammandArray[
            (randomNumber % pathCammandArray.length)
        ];
        uint256 size = ContractData.getUintValue("size");
        uint256 parametersOne = uint256(
            keccak256(abi.encode(randomNumber, size))
        ) % size;
        uint256 parametersTwo = uint256(
            keccak256(abi.encode(randomNumber, size))
        ) % size;
        pathCommand = string(
            abi.encodePacked(
                pathCommand,
                " ",
                toString(parametersOne),
                " ",
                toString(parametersTwo)
            )
        );
    }
}
