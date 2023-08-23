// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.3;

contract crowdfunding{
    enum State{
        IN_PROGRESS,
        ENDED
    }

    address payable public owner;
    State public currentState;

    constructor(){
        owner=payable (msg.sender);
    }

    //check state of the funding
    modifier stillInProgress(){
        require(currentState==State.IN_PROGRESS,"donation phase is no longer in progress");
        _;
    }

    //donate any user address
    function donate() external payable stillInProgress{}

    // check total collected amount
    function checkAmountCollected() public view stillInProgress returns (uint){
        return address(this).balance;
    }

    //withdraw only done by owner address
    function withdraw() external{
        require(msg.sender==owner,"only the owner can withdrew");
        owner.transfer(address(this).balance);
        currentState=State.ENDED;
    }
}
