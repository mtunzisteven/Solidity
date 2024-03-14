// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title ErrorHandling
 * @dev Description
 */
contract ErrorHandling {

    // Asset, Require, Revert and Exceptions
    
    // assert(bool condition) — In case codition is not met, this method call causes
    // an invalid opcode and any changes done to state got reverted. Used for internal
    // errors.

    // require(bool condition) — In case codition is not met, this method call causes
    // an invalid opcode and any changes done to state got reverted. Used in inputs
    //  or external components errors.

    // require(bool condition) or require(bool condition, string memory message) —
    // In case codition is not met, this method call causes an invalid o
    // pcode and any changes done to state got reverted. Used in inputs
    //  or external components errors. Provides custom message option.

    // revert() or revert(string memory message) — Aborts the execution and revert any
    // changes done to the state. Provides custom message option.

}