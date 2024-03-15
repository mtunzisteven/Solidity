// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title Events
 * @dev Description
 */
contract Events {
    // An inheritable member of a contract
    // Can be emitted to record on blockchain
    // Created to capture events and defined like function

    // Declare:
    // event Event_Name(address indexed _from, bytes32 indexed _id, uit _value);

    // Emit:
    // emit Event_Name(msg.sender, _id, msg.value)

    event Log(address indexed sender, string message); // event with sender address and message
    event AnotherLog(); // empty event

    function test() public {
        emit Log(msg.sender, "Hello World");
        emit Log(msg.sender, "Hello EVM");
        emit AnotherLog();
    }

    
}