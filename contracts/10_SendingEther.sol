// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title SendingEther
 * @dev Description
 */
contract SendingEther {

    // Send: transfer, send, call
    
    // transfer(gas_value, throws error).
    // send(gas_value, returns bool).
    // call(forward all gas or set gas, returns bool). *recommended


    // Receive: Receive, Fallback

    // receive() external payable. Used when msg.data is empty
    // fallback() external payable. Used when msg.data is not empty

}