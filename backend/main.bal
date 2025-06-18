import ballerina/http;
import backend.database;
import ballerina/log;

service /user\-managment on new http:Listener(9090) {

    # Insert user
    #
    # + userInsert - UserInsert record containing user details
    # + return - http:Created status with user ID|InternalServerError with error message
    resource function put users(UserInsert userInsert) returns http:Created|http:InternalServerError{

        int|error userId = database:insertUser(userInsert);

        //Handle : error while creating user
        if userId is error {
            string customeError = string `Error occurred while adding user`;
            log:printError(customeError, userId);
            return <http:InternalServerError>{
                body:  {
                    message: customeError
                }
            };
        }

        return <http:Created>{
            body:  userId
        };
        
    }
}