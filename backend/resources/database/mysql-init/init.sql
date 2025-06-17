-- Active: 1749700663771@@127.0.0.1@3306
USE user_management_database;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    mobile_number VARCHAR(10),
    email VARCHAR(255)
);

INSERT INTO users (first_name, last_name, mobile_number, email) VALUES
    ("Punjitha", "Bandara", "0772932779", "punjitha@tyrnt.co"),
    ("Bruce", "Wayne", "0771111111", "bruce@wayne.co");