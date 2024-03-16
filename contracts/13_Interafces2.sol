// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./12_Interfaces.sol";

/** 
 * @title MyContract
 * @dev Description
 */
abstract contract MyContract is MyInterface {
    uint private x = 12;
    uint private y = 23;

    function getString() public pure returns(string memory) {
        return "Hellow World!";
    }

    function setValue(uint _a, uint _b) public {
        x = _a;
        y = _b;
    }

    function add(uint _a, uint _b) public pure returns(uint) {
        return _a + _b;
    }
}