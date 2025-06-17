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