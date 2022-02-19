// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract Candidate {

    struct  candidateStruct{
        string fName;
        string lName;
        string partyName;
        string partySymbol;
        address ethereumAccount;
    }

    mapping(string => uint) private partyname_index;
    mapping(address => uint) private address_index;

    uint private count;
    address private electionComission;

    candidateStruct[] private candidateStruct_arr;

    constructor( address _electionComission) {
        electionComission=_electionComission;
        count=0;
    }

    function insertCandidate(string calldata _fname,string calldata _lname,string calldata _partyName,string calldata _partySymbol,address  _address)  external {
        require (msg.sender==electionComission,"You did not allow to insert Candidate");
        candidateStruct memory candidateStruct_obj;
        candidateStruct_obj.fName=_fname;
        candidateStruct_obj.lName=_lname;
        candidateStruct_obj.partyName=_partyName;
        candidateStruct_obj.partySymbol=_partySymbol;
        candidateStruct_obj.ethereumAccount=_address;
        partyname_index[_partyName]=count;
        address_index[_address]=count;
        count++;
        candidateStruct_arr.push(candidateStruct_obj);

    }

    function getCandidateByPartyName(string calldata _partyName) public view returns(candidateStruct memory candidateStruct_obj){
     uint i = partyname_index[_partyName];
     return candidateStruct_arr[i];    
    }

    function getCandidateAddress(string calldata _partyName) public view returns(address  _address){
     uint i = partyname_index[_partyName];
     return candidateStruct_arr[i].ethereumAccount;    
    }

    function getCandidateByAddress(address  _address) public view returns(candidateStruct memory candidateStruct_obj){
     uint i = address_index[_address];
     return candidateStruct_arr[i];    
    }

    function getAllCandidatePartName() public view returns(string[]  memory _partyNames){
    _partyNames =new string[](candidateStruct_arr.length);
        for (uint i=0;i<candidateStruct_arr.length;i++){
            _partyNames[i]=candidateStruct_arr[i].partyName;
        }
        return _partyNames;
    }
}