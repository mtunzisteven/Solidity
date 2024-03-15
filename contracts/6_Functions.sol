// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./2_Owner.sol";

/** 
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
contract Functions is Owner {

    constructor() payable {
        owner = payable(owner);
    }

    // Signature : function function_name(parameter_list) scope returns(type) { block of code }
    // visibility: public, private, and external
    // modifiers: can change the behavior of a function
    //      pure, view, payable, virtual, override

    // Modifiers can change functions in a declarative way:
    modifier onlyOwner{
        require(msg.sender == owner, "Only owner can call");
        _; // function calling this modifier can continue if above check passes
    }

    
    function getBalance() view public onlyOwner returns(uint) {
    // the function gets remaining wei in this contract owner's balance

        return owner.balance;
    }
    
    uint public x = 1;

    // pure: disallows function from modifying or accessing state variables
    function add(uint i, uint j) public pure returns(uint) { return i+j; }

    // view: disallows function from modifying state variables
    function addToX(uint y) public view returns(uint) { return x+y; }

    // payable: Allows function to receive Ether together with a call
    function deposit() public payable { 

     }

    function notPayable() public {

    }

    function withdraw() public onlyOwner{
        // owner is payable, so function does not fail since it is not payable

        // get amount of Ether stored in this contract
        uint amount = address(this).balance;

        // send all Ether owner
        // Owner can receive Ether since the address of owner is payable
        (bool success, ) = owner.call{value: amount}(""); // (trancationStatus, dataReturned) = address.call(value: transactionAmount}(dataReturned);
        require(success, "Failed to send Ether");

    }

    function transfer(address payable _to, uint _amount) payable public {
        // Note that "to" is declared as payable
        (bool success, ) = _to.call{value: _amount}(""); // (trancationStatus, dataReturned) = address.call(value: transactionAmount}(dataReturned);
        require(success, "Failed to send Ether");

    }

    function getContractBalance() view public returns(uint) {
    // the function gets remaining wei in this contract
    
        return address(this).balance;
    }

    receive() external payable { } // used in contracts that allow owner to receive money

    fallback() external payable { } // another fn used in contracts that allow owner to receive money when receiveed isnot defined and no datasent

    // virtual: For functions and modifiers — Allows function's or modifier's  behavior to be changed in derived contracts

    // override: declares that this function, modifier, or public variable change the behavior of a function or modifier in a base contract.
}