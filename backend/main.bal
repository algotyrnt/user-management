import ballerina/http;
import backend.database;
import ballerina/log;
import ballerina/sql;

service /user\-managment on new http:Listener(9090) {

    # Insert user
    #
    # + newUser - newUser record containing user details
    # + return - http:Created status with user ID|InternalServerError with error message
    resource function post users(NewUser newUser) returns http:Created|http:InternalServerError{

        int|error userId = database:insertUser(newUser);

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

    # Get a user by Id
    # 
    # + userId - Id of the user
    # + return - User rcord|NotFoundError|InternalServerError
    resource function get users/[int userId]() returns User|http:NotFound|http:InternalServerError {
        
        User|error user = database:getUserById(userId);

        //Handle : user not found error
        if user is sql:NoRowsError {
            string customeError = string `User not found with id: ${userId}`;
            log:printError(customeError);
            return <http:NotFound>{
                body:  {
                    message:customeError
                }
            };
        }

        //Handle : error while fetching user
        if user is error {
            string customeError = string `Error occurred while fetching user with id: ${userId}`;
            log:printError(customeError, user);
            return <http:InternalServerError>{
                body:  {
                    message: customeError
                }
            };
        }

        return user;
    } 

}