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
    User|sql:Error user = databaseClient->queryRow(getUserById(userID));

    if user is sql:Error && user is sql:NoRowsError {
        return;
    }

    return user;
}