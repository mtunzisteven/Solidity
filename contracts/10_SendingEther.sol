// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./2_Owner.sol";


/** 
 * @title SendingEther
 * @dev Description
 */
contract SendingEther is Owner {

    constructor() payable {
        owner = payable(owner);
    }

    function sendViaTransfer(address payable _to) public payable {
        // this function is no longer recommended for sending Ether
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        // Send returns a boolean value indicating success or falilure.
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViaCall(address payable _to) public payable {
        // Call returns a boolean value indicating success or falilure.
        // This is the current recommended method to use
        (bool sent, )= _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

    function getBalance() view public isOwner returns(uint) {
    // the function gets remaining wei in this contract owner's balance

        return owner.balance;
    }

    function getContractBalance() view public returns(uint) {
    // the function gets remaining wei in this contract
    
        return address(this).balance;
    }

}