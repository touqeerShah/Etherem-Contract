// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
contract stateMachine {

    enum States{
        inits,
        deposit,
        ship,
        withdraw
    }

    address buyer;
    address seller;
    States  public currentState = States.inits;
    error RestructionStatus();

    modifier StateRestrict(States _state){
        if(currentState!= _state){
            revert RestructionStatus();
            
        }
        if(currentState!=States.withdraw){
            currentState =States(uint(currentState)+1);
        }
        _;


    }

    function initStatus(address _buyer,address _seller) public StateRestrict(States.inits){
        buyer=_buyer;
        seller=_seller;
    }
    function deposit() public StateRestrict(States.deposit) payable{
    
    }
    function ship() public StateRestrict(States.ship){
    
    }
    function withdraw() public StateRestrict(States.withdraw) payable{
    
    }


}

