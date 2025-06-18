import ballerina/http;
import backend.database;
import ballerina/log;
import ballerina/sql;

service /user\-management on new http:Listener(9090) {

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

    # Get all users
    #
    # + return - Array of User records|InternalServerError
    resource function get users() returns User[]|http:InternalServerError {
        User[]|error users = database:getAllUsers();

        //Handle : error while fetching users
        if users is error {
            string customError = "Error occurred while fetching users";
            log:printError(customError, users);
            return <http:InternalServerError>{
                body: {
                    message: customError
                }
            };
        }

        return users;
    }

    # Update user details
    #
    # + user - Updated user entity
    # + return - Ok status if updated successfully|InternalServerError with error message|NotFound error
    resource function put users(User user) returns http:Ok|http:NotFound|http:InternalServerError{
        int|error rowsAffected = database:updateUser(user);

        //Handle : user not found error
        if rowsAffected is sql:NoRowsError {
            string customeError = string `User not found with id: ${user.id}`;
            log:printError(customeError);
            return <http:NotFound>{
                body:  {
                    message:customeError
                }
            };
        }

        //Handle : error while updating user
        if rowsAffected is error {
            string customError = "Error occurred while updating user";
            log:printError(customError, rowsAffected);
            return <http:InternalServerError>{
                body: {
                    message: customError
                }
            };
        }

        //Handle : user details not updating in db
        if rowsAffected is 0 {
            string customError = "User did not updated";
            log:printError(customError);
            return <http:InternalServerError>{
                body: {
                    message: customError
                }
            };
        }

        return <http:Ok>{
            body:  string `user details updated`
        };
    }
}