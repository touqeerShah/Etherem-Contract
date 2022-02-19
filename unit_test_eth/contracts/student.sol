// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Student {
  address public owner = msg.sender;
  uint public last_completed_migration;

  string public name;
  uint public age;
  bool public isStudent;

constructor(){
    name="Ali";
    age=17;
    isStudent=true;
    last_completed_migration=420;
}
modifier restricted() {
    require(
      msg.sender == owner,
      "This function is restricted to the contract's owner"
    );
    _;
  }   
  function setStudent(string calldata _name,uint _age,bool _isStudent) public  {
    name =_name;
    age=_age;
    isStudent=_isStudent;
  }
  function getStudent() public view returns(string memory _name,uint _age,bool _isStudent)  {
   return(name,age,isStudent);
  }

  function getCompleted() public view restricted returns(uint completed)  {
    return last_completed_migration;
  }
}
