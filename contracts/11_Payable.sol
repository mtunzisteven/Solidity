// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./2_Owner.sol";


/** 
 * @title SendingEther
 * @dev Description
 */
contract Payable is Owner {

    // Events to record on log
    event Withdrawal( address indexed _to, address indexed _contract, uint256 _amount );
    event Transfer( address indexed _from, address indexed _to, uint256 _amount);

    constructor() payable {
        owner = payable(owner);
    }

    function deposit() public payable { 
        // Allows function to receive Ether together with a call

    }

    function transfer(address payable _to, uint _amount) public payable {
        // Note that "to" is declared as payable
        (bool success, ) = _to.call{value: _amount}(""); // (trancationStatus, dataReturned) = address.call(value: transactionAmount}(dataReturned);
        require(success, "Failed to send Ether");
        emit Withdrawal(msg.sender, _to, _amount);

    }


    function withdraw() public isOwner{
        // owner is payable, so function does not fail since it is not payable

        // get amount of Ether stored in this contract
        uint amount = address(this).balance;

        // send all Ether owner
        // Owner can receive Ether since the address of owner is payable
        (bool success, ) = owner.call{value: amount}(""); // (trancationStatus, dataReturned) = address.call(value: transactionAmount}(dataReturned);
        require(success, "Failed to send Ether");
        emit Withdrawal(msg.sender, address(this), amount);

    }

    function getBalance() view public isOwner returns(uint) {
        // the function gets remaining wei in this contract owner's balance

        return owner.balance;
    }

    function getContractBalance() view public returns(uint) {
        // the function gets remaining wei in this contract
    
        return address(this).balance;
    }

    receive() external payable { } // used in contracts that allow owner to receive money

    fallback() external payable { } // another fn used in contracts that allow owner to receive money when receiveed isnot defined and no datasent

}