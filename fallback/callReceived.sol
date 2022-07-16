// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
contract testRecevied {
    uint public y;
    event Receviedcalled(string);

    function getBalance() public view returns (uint balance) {
        return address(this).balance;
    }

    fallback() external payable {
        y++;
        emit Receviedcalled("Non existing fallback called");
    }

    receive() external payable {
        y++;
        emit Receviedcalled("Non existing Recevied called");
    }
}
