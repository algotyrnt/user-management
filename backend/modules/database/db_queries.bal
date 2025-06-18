import ballerina/sql;

# Build query to insert a user into the database
# 
# + newUser - newUser record containing user details
# + return - sql:ParameterizedQuery - SQL query to insert a user
isolated function insertUserQuerry(NewUser newUser) returns sql:ParameterizedQuery {
    sql:ParameterizedQuery query =

    `INSERT INTO users (first_name, last_name, mobile_number, email) 
     VALUES (
        ${newUser.firstName}, 
        ${newUser.lastName}, 
        ${newUser.mobileNumber}, 
        ${newUser.email})`
    ;

    return query;
}

# Build query to retrieve all users from the database
#
# + return - sql:ParameterizedQuery - SQL query to select all users
isolated function getAllUsersQuerry() returns sql:ParameterizedQuery {
    sql:ParameterizedQuery query = 
    
    `SELECT * FROM users`;

    return query;
}

# Build query to retrieve a user by Id from the database
#
# + userId - Id of the user to retrieve
# + return - sql:ParameterizedQuery - SQL query to select a user by Id
isolated function getUserByIdQuerry(int userId) returns sql:ParameterizedQuery {
    sql:ParameterizedQuery query = 
    
    `SELECT * FROM users WHERE id = ${userId}`;

    return query;
}

# Build query to search and retrieve a user by name from the database
# 
# + nameInput - name of the user
# + return - sql:ParameterizedQuery - SQL query to select a user by name
isolated function searchUserByNameQuerry(string nameInput) returns sql:ParameterizedQuery {
    string pattern = "%" + nameInput + "%";

    sql:ParameterizedQuery query =

    `SELECT * FROM users WHERE first_name LIKE ${pattern}
     OR last_name LIKE ${pattern}
     OR CONCAT(first_name, ' ', last_name) LIKE ${pattern}`;

    return query;
}

# Build query to update a user in the database
#
# + user - User record containing updated user details
# + return - sql:ParameterizedQuery - SQL query to update a user
isolated function updateUserQuerry(User user) returns sql:ParameterizedQuery {
    sql:ParameterizedQuery query =

    `UPDATE users 
     SET
        first_name = ${user.firstName},
        last_name = ${user.lastName},
        mobile_number = ${user.mobileNumber},
        email = ${user.email}
     WHERE id = ${user.id}`;

    return query;
}

# Build query to delete a user by Id in the database
# 
# + userId - Id of the user to delete
# + return - sql:ParameterizedQuery - SQL query to delete a user by ID
isolated function deleteUserByIdQuerry(int userId) returns sql:ParameterizedQuery {
    sql:ParameterizedQuery query =
    
    `DELETE FROM users WHERE id = ${userId}`;

    return query;
}