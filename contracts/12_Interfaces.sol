// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// Similar to contract but have the following restrictions:
// - Can't implement functions.
// - Can't inherit from contract, only from other interfaces.
// - All declared funtions must be external.
// - Can't declare constructor.
// - Can't declare state variables.
// - Can't declare modifiers.

/** 
 * @title MyInterface
 * @dev Description
 */
interface MyInterface {
    
    // Functions have only declaration, not implementation
    function getString() external view returns(string memory);
    function setValue() external;
    function add(uint  x, uint y) external view returns(uint);

    
}

// abstract contract MyContract is MyInterface {
//     uint private x = 12;
//     uint private y = 23;

//     function getString() public pure returns(string memory) {
//         return "Hellow World!";
//     }

//     function setValue(uint _a, uint _b) public {
//         x = _a;
//         y = _b;
//     }

//     function add(uint _a, uint _b) public pure returns(uint) {
//         return _a + _b;
//     }
// }