// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


// school management system with student and teacher registration, fee payment, and salary management
// student can register with their name, age, and grade, and pay their fees
// teacher can register with their name, subject, and salary, and receive their salary payments
// students must belog to a level and their fees is dependent on the level 
// payment is with erc20 toke using openzeppelin 




contract SchoolManagement {

    address public admin;
    mapping(address => bool) public isAdmin;

    constructor() {
        admin = msg.sender;
        isAdmin[msg.sender] = true;
    }

    modifier onlyAdmin() {
        require(isAdmin[msg.sender], "Only admin can perform this action");
        _;
    }

    // student struct and mappings
    struct Student {
        uint256 id;
        string name;
        uint8 age;
        uint8 grade;
        bool hasPaid;
    }
    mapping(uint256 => Student) public students;
    uint256 public studentCount;

    // teacher struct and mappings
    struct Teacher {
        uint256 id;
        string name;
        string subject;
        uint256 salary;
        bool isPaid;
    }
    mapping(uint256 => Teacher) public teachers;
    uint256 public teacherCount;


    // events
    event studentRegistered(
        uint256 indexed id,
        string name,
        uint8 age,
        uint8 grade
    );
    event teacherRegistered(uint256 indexed id, string name, string subject);

    function registerStudent(
        uint256 id,
        string memory name,
        uint8 age,
        uint8 grade
    ) public onlyAdmin {
        require(students[id].id == 0, "Student with this ID already exists");

        studentCount++;
        students[studentCount] = Student({
            id: studentCount,
            name: name,
            age: age,
            grade: grade,
            hasPaid: false
        });

        emit studentRegistered(studentCount, name, age, grade);
    }

    function registerTeacher(
        uint256 id,
        string memory name,
        string memory subject,
        uint256 salary
    ) public onlyAdmin {
        require(teachers[id].id == 0, "Teacher with this ID already exists");
        teacherCount++;

        teachers[teacherCount] = Teacher({
            id: teacherCount,
            name: name,
            subject: subject,
            salary: salary,
            isPaid: false
        });
        emit teacherRegistered(teacherCount, name, subject);
    }
}
