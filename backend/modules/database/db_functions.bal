import ballerina/sql;

# Insert user
# 
# + newUser - UserInsert record containing user details
# + return - Id of the user|Error
public isolated function insertUser(UserInsert newUser) returns int|error {
    sql:ExecutionResult|error executionResult = databaseClient->execute(insertUser(newUser));

    if executionResult is error {
        return executionResult;
    }

    return executionResult.lastInsertId;
}

# Fetch user by Id
# 
# + userId - Id of the user
# + return - User|Error
public isolated function getUserById(int userID) returns User|error {
    User|error user = databaseClient->queryRow(getUserById(userID));

    return user;
}

# Fetch all the users
# 
# + return - List of all users|Error
public isolated function getAllUsers() returns Users[]|error {
    User[]|error users = databaseClient->queryRow(getAllUsers());

    return users;
} 

# Search user by name
# 
# + nameInput - name of the user
# + return - List of possible users|Error
public isolated function searchUserByName(string nameInput) returns Users[]|error {
    User[]|error users = databaseClient->queryRow(searchUserByName(nameInput));

    return users;
}