//SPDX-License-Identifier: Unlicense
//give the contract SVG code
//Output will be the NFT of that SVG
//Store that NFT MateData on Chain

pragma solidity ^0.8.0;
import "base64-sol/base64.sol";

contract helperContract {
    function toString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    function svgToImageURI(string memory svg)
        public
        pure
        returns (string memory)
    {
        // example:
        // <svg width='500' height='500' viewBox='0 0 285 350' fill='none' xmlns='http://www.w3.org/2000/svg'><path fill='black' d='M150,0,L75,200,L225,200,Z'></path></svg>
        // data:image/svg+xml;base64,<Base64-encoded String>
        string memory baseURI = "data:image/svg+xml;base64,";
        string memory svgURI = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        string memory imageURI = string(abi.encodePacked(baseURI, svgURI));
        return imageURI;
    }

    function formatTokenURI(string memory nftName, string memory imageURI)
        public
        pure
        returns (string memory)
    {
        // example:
        // data:application/json;base64,<imageUIR>
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                nftName, // You can add whatever name here
                                '", "description":',
                                '"An ',
                                nftName,
                                ' based on SVG!"',
                                ', "attributes":""',
                                ',"image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
