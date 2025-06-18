import ballerina/sql;

# Build query to insert a user into the database
# 
# + newUser - UserInsert record containing user details
# + return - sql:ParameterizedQuery - SQL query to insert a user
isolated function insertUser(UserInsert newUser) returns sql:ParameterizedQuery {
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
isolated function getAllUsers() returns sql:ParameterizedQuery {
    sql:ParameterizedQuery query = 
    
    `SELECT * FROM users`;

    return query;
}

# Build query to retrieve a user by ID from the database
#
# + userId - ID of the user to retrieve
# + return - sql:ParameterizedQuery - SQL query to select a user by ID
isolated function getUserById(int userId) returns sql:ParameterizedQuery {
    sql:ParameterizedQuery query = 
    
    `SELECT * FROM users WHERE id = ${userId}`;

    return query;
}

# Build query to update a user in the database
#
# + user - User record containing updated user details
# + return - sql:ParameterizedQuery - SQL query to update a user
isolated function updateUser(User user) returns sql:ParameterizedQuery {
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