// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
contract ContractStorage {
    mapping(bytes32 => uint256) private uintVaraibale;
    mapping(bytes32 => string) private stringVaraibale;
    mapping(bytes32 => string[]) private stringArrayVaraibale;
    mapping(bytes32 => bytes32) private bytes32Varaibale;

    mapping(bytes32 => address) private requestIdToSender;
    mapping(uint256 => uint256) private tokenIdToRandomNumber;

    function setUintVar(bytes32 var_name, uint256 var_value) public {
        uintVaraibale[var_name] = var_value;
    }

    function getUintVar(bytes32 var_name) public view returns (uint256 val) {
        return uintVaraibale[var_name];
    }

    function setStringVar(bytes32 var_name, string calldata var_value) public {
        stringVaraibale[var_name] = var_value;
    }

    function getStringVar(bytes32 var_name)
        public
        view
        returns (string memory val)
    {
        return stringVaraibale[var_name];
    }

    function setStringArrayVar(bytes32 var_name, string[] memory var_value)
        public
    {
        stringArrayVaraibale[var_name] = var_value;
    }

    function getStringArrayVar(bytes32 var_name)
        public
        view
        returns (string[] memory val)
    {
        return stringArrayVaraibale[var_name];
    }

    function setBytes32Var(bytes32 var_name, bytes32 var_value) public {
        bytes32Varaibale[var_name] = var_value;
    }

    function getBytes32Var(bytes32 var_name) public view returns (bytes32 val) {
        return bytes32Varaibale[var_name];
    }

    function setRequestIdToSenderVar(bytes32 var_name, address var_value)
        public
    {
        requestIdToSender[var_name] = var_value;
    }

    function getRequestIdToSenderVar(bytes32 var_name)
        public
        view
        returns (address val)
    {
        return requestIdToSender[var_name];
    }

    function setTokenIdToRandomNumber(uint256 tokenId, uint256 var_value)
        public
    {
        tokenIdToRandomNumber[tokenId] = var_value;
    }

    function getTokenIdToRandomNumber(uint256 tokenId)
        public
        view
        returns (uint256 val)
    {
        return tokenIdToRandomNumber[tokenId];
    }
}

library ContractLib {
    function setUintValue(
        address _contractStorage,
        string calldata var_name,
        uint256 var_value
    ) public {
        ContractStorage(_contractStorage).setUintVar(
            keccak256(bytes(var_name)),
            var_value
        );
    }

    function getUintValue(address _contractStorage, string calldata var_name)
        public
        view
        returns (uint256)
    {
        return
            ContractStorage(_contractStorage).getUintVar(
                keccak256(bytes(var_name))
            );
    }

    /////////////////////////////////////// uint mapping with bytes32 argument to set variable name
    function setUintWithBytes32NameValue(
        address _contractStorage,
        bytes32 var_name,
        uint256 var_value
    ) public {
        ContractStorage(_contractStorage).setUintVar(var_name, var_value);
    }

    function getUintWithBytes32NameValue(
        address _contractStorage,
        bytes32 var_name
    ) public view returns (uint256) {
        return ContractStorage(_contractStorage).getUintVar(var_name);
    }

    //////////////////////////////////////////////////////////////////////////////////////////////

    function setStringValue(
        address _contractStorage,
        string calldata var_name,
        string calldata var_value
    ) public {
        ContractStorage(_contractStorage).setStringVar(
            keccak256(bytes(var_name)),
            var_value
        );
    }

    function getStringValue(address _contractStorage, string memory var_name)
        public
        view
        returns (string memory)
    {
        return
            ContractStorage(_contractStorage).getStringVar(
                keccak256(bytes(var_name))
            );
    }

    function setStringArrayValue(
        address _contractStorage,
        string calldata var_name,
        string[] memory var_value
    ) public {
        ContractStorage(_contractStorage).setStringArrayVar(
            keccak256(bytes(var_name)),
            var_value
        );
    }

    function getStringArrayValue(
        address _contractStorage,
        string memory var_name
    ) public view returns (string[] memory) {
        return
            ContractStorage(_contractStorage).getStringArrayVar(
                keccak256(bytes(var_name))
            );
    }

    function setBytes32Value(
        address _contractStorage,
        string calldata var_name,
        bytes32 var_value
    ) public {
        ContractStorage(_contractStorage).setBytes32Var(
            keccak256(bytes(var_name)),
            var_value
        );
    }

    function getBytes32Value(address _contractStorage, string memory var_name)
        public
        view
        returns (bytes32)
    {
        return
            ContractStorage(_contractStorage).getBytes32Var(
                keccak256(bytes(var_name))
            );
    }

    function setRequestIdToStringValue(
        address _contractStorage,
        bytes32 var_name,
        address var_value
    ) public {
        ContractStorage(_contractStorage).setRequestIdToSenderVar(
            var_name,
            var_value
        );
    }

    function getRequestIdToStringValue(
        address _contractStorage,
        bytes32 var_name
    ) public view returns (address) {
        return
            ContractStorage(_contractStorage).getRequestIdToSenderVar(var_name);
    }

    function setTokenIdToRandomNumberValue(
        address _contractStorage,
        uint256 tokenId,
        uint256 var_value
    ) public {
        ContractStorage(_contractStorage).setTokenIdToRandomNumber(
            tokenId,
            var_value
        );
    }

    function getTokenIdToRandomNumberValue(
        address _contractStorage,
        uint256 tokenId
    ) public view returns (uint256) {
        return
            ContractStorage(_contractStorage).getTokenIdToRandomNumber(tokenId);
    }
}
