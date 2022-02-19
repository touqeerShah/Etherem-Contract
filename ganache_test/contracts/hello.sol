// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract Student {
int private age;
string private name;
address private owner;
bool private isStudent;


function setStudentInfo(int _age, string calldata _name, bool _isStudent) public{

    name=_name;
    age=_age;
    isStudent=_isStudent;
}


function getStudentInfo() public view returns( int ,string memory,bool){
    return(age,name,isStudent);
}


}
