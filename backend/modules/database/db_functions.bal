import ballerina/sql;

# Insert user
# 
# + newUser - UserInsert record containing user details
# + return - Id of the user
public isolated function insertUser(UserInsert newUser) returns int|error {
    sql:ExecutionResult|error executionResult = databaseClient->execute(insertUser(newUser));

    if executionResult is error {
        return executionResult;
    }

    return executionResult.lastInsertId;
}
