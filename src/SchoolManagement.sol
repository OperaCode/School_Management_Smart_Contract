// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

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

    struct Student {
        uint256 id;
        string name;
        uint8 age;
        uint8 grade;
        bool hasPaid;
    }
    mapping(uint256 => Student) public students;
    uint256 public studentCount;

    struct Teacher {
        uint256 id;
        string name;
        string subject;
        uint256 salary;
        bool isPaid;
    }
    mapping(uint256 => Teacher) public teachers;
    uint256 public teacherCount;

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
