import ballerina/sql;

# Insert user
# 
# + newUser - UserInsert record containing user details
# + return - Id of the user|Error
public isolated function insertUser(UserInsert newUser) returns int|error {
    sql:ExecutionResult|error executionResult = databaseClient->execute(insertUserQuerry(newUser));

    if executionResult is error {
        return executionResult;
    }

    return <int>executionResult.lastInsertId;
}

# Fetch user by Id
# 
# + userId - Id of the user
# + return - User|Error
public isolated function getUserById(int userId) returns User|error {
    User|error user = databaseClient->queryRow(getUserByIdQuerry(userId));

    return user;
}

# Fetch all the users
# 
# + return - List of all users|Error
public isolated function getAllUsers() returns User[]|error {
    User[]|error users = databaseClient->queryRow(getAllUsersQuerry());

    return users;
} 

# Search user by name
# 
# + nameInput - name of the user
# + return - List of possible users|Error
public isolated function searchUserByName(string nameInput) returns User[]|error {
    User[]|error users = databaseClient->queryRow(searchUserByNameQuerry(nameInput));

    return users;
}