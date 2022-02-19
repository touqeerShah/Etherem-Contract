// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Candidate.sol";
contract Voter {

    struct voter{
        string nic;
        address ethereumAccount;
    }
    struct VoterParty{
        string nic;
        uint index;
        address ethereumAccount;
    }
    mapping(address=>voter[]) private voters;
    Candidate private candidateObj;
    mapping(address=>VoterParty) private VoterPartAddress;



    constructor(address _address) {

        candidateObj= Candidate(_address);
    }
    function insertVoteByPartyName(string memory _nic,string calldata _partyName) public{
        address part_address= candidateObj.getCandidateAddress(_partyName);
        require (part_address!=address(0),"This part does not exist");
        require (VoterPartAddress[msg.sender].ethereumAccount==address(0),"Your Vote is Already caste");

        voter memory newVoter;
        newVoter.nic=_nic;
        newVoter.ethereumAccount=msg.sender;        
        voters[part_address].push(newVoter);

        VoterParty memory voterParty;
        voterParty.nic=_nic;
        voterParty.index=(voters[part_address].length-1);

        voterParty.ethereumAccount=part_address;        
        VoterPartAddress[msg.sender]=voterParty;
    }
    function getVoteCount(string calldata _partyName) public view returns(uint count){
        address part_address= candidateObj.getCandidateAddress(_partyName);
        require (part_address!=address(0),"This part does not exist");
        return voters[part_address].length;
    }


    function verifyVote(string calldata _partyName) public view returns(string memory nic,uint index){
        address part_address= candidateObj.getCandidateAddress(_partyName);
        require (part_address!=address(0),"This part does not exist");
        if(part_address==VoterPartAddress[msg.sender].ethereumAccount){
            return (VoterPartAddress[msg.sender].nic, VoterPartAddress[msg.sender].index);
        }
    }

}