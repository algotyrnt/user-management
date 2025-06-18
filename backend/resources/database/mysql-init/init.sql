-- Active: 1749700663771@@127.0.0.1@3306
USE user_management_database;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    mobile_number VARCHAR(10) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

INSERT INTO users (first_name, last_name, mobile_number, email) VALUES
    ("Sample", "User1", "0991111111", "sample-user1@user-management"),
    ("Sample", "User2", "0992222222", "sample-user2@user-management");