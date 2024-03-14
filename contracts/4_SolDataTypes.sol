// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
contract Types { 

    // modifiers: can change the behavior of a state variable
    //      constant, immutable, anonymous, indexed

    // constant: same as in JS
    // immutable: Allows eexactly one assignemnt at construction time and is a constant aftwards. Stored in code.
    // anonymous: For events — Does not store event signature as topic
    // indexed: For event params — Store param as topic

    bool public boolean = false;

    uint public uint_var = 654;

    uint256 public uint256_var = 6545654;

    int32 public int_var = -2256;

    string public str = "Hellow there";

    bytes1 public b = "b"; //0x62

    enum my_enum { _st, _mid, _end }

    function Enum() public pure returns (my_enum) {
        return my_enum._mid;
    }


}