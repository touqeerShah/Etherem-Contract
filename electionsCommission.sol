// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Candidate.sol";
import "./Voter.sol";
contract ElectionComission {
    address private ec_admin;
    Candidate private candidateObj;
    Voter     private voterObj;
    constructor() 
        {
            ec_admin = msg.sender;
            candidateObj = new Candidate(address(this));
            voterObj = new Voter();
    }
    modifier is_ECAdmin(){
        require(msg.sender==ec_admin,"You did not Allow to Access ");
        _;
    }

    function getCandidateContractAddress() public view returns(address _candidateObj){
        return address(candidateObj);
    }
    function getVoterContractAddress() public view returns(address _voterObj){
        return address(voterObj);
    }

    function insertNewCandidate(string calldata _fname,string calldata _lname,string calldata _partyName,string calldata _partySymbol,address _address) public is_ECAdmin  {
       candidateObj.insertCandidate(_fname,_lname,_partyName,_partySymbol,_address);
    }
}