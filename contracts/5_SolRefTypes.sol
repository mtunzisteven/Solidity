// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
contract ReferenceTypes { 

    address public owner;

    //array ref type
    uint[5] public array
    = [uint(1), 2, 3, 4, 5];

    // Structure
    struct student {
        string name;
        string subject;
        uint8 marks;
    }

    // Creating a structure object
    student public std1;

    constructor() {
        owner = msg.sender;
    }

    // Defining a function to return
    // values of the elements of the structure
    function structure() public returns(
        string memory,
        string memory,
        uint
    ) {
        std1.name = "John";
        std1.subject = "Chemistry";
        std1.marks = 88;

        return (
            std1.name,
            std1.subject,
            std1.marks
        );
    }

    // Creating a mapping
    mapping (address => student) public result; // creating a mapping to student to address to give "address: student" key pair called result 
    address[] public student_result; // creating an array of student "address" values called student_result

    // fucntion for recording a student: 
    // _student arg is of student type, which is a structure.
    // Expected input is an array: ["Mtunzi", "Solidity", 100] ~ single quotes will not work
    // addStudent arg is an address for the student
    // Expected input is an address: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    function record(student memory _student, address addStudent) public {

        // Make sure user is owner first
        require(msg.sender == owner, 'only Admin');

        result [ addStudent ] = _student; // a 'result' mapping, hwich sets a 'address: student' key-pair
        student_result.push(addStudent); // an address of a student record is stored in an addresses array
    }

}