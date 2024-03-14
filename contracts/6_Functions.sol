// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./2_Owner.sol";

/** 
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
contract Functions is Owner {

    // Signature : function function_name(parameter_list) scope returns(type) { block of code }
    // visibility: public, private, and external
    // modifiers: can change the behavior of a function
    //      pure, view, payable, virtual, override

    // Modifiers can change functions in a declarative way:
    modifier onlyOwner{
        require(msg.sender == owner, "Only owner can call");
        _; // function calling this modifier can continue if above check passes
    }

    // the function gets remaining gas in wei
    function getGas() view public onlyOwner returns(uint) {

        return owner.balance;
    }
    
    uint public x = 1;

    // pure: disallows function from modifying or accessing state variables
    function add(uint i, uint j) public pure returns(uint) { return i+j; }

    // view: disallows function from modifying state variables
    function addToX(uint y) public view returns(uint) { return x+y; }

    // pure: Allows function to receive Ether together with a call

    // virtual: For functions and modifiers — Allows function's or modifier's  behavior to be changed in derived contracts

    // override: declares that this function, modifier, or public variable change the behavior of a function or modifier in a base contract.
}