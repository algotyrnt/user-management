import ballerina/http;
import backend.database;
import ballerina/log;
import ballerina/sql;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["http://localhost:5173"],
        allowMethods: ["GET", "POST", "PUT", "DELETE"],
        allowHeaders: ["Content-Type"]
    }
}

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
            body:  {id: userId,
                    ...newUser
            }
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
            string customError = "User did not get updated";
            log:printError(customError);
            return <http:InternalServerError>{
                body: {
                    message: customError
                }
            };
        }

        return <http:Ok>{
            body:  {...user}
        };
    }

    # Delete user by id
    # 
    # + userId - Id of the user
    # + return - NoContent if deleted successfully|InternalServerError with error message|NotFound error
    resource function delete users/[int userId]() returns http:NoContent|http:NotFound|http:InternalServerError {
        int|error rowsAffected = database:deleteUserById(userId);

        //Handle : user not found error
        if rowsAffected is sql:NoRowsError {
            string customeError = string `User not found with id: ${userId}`;
            log:printError(customeError);
            return <http:NotFound>{
                body:  {
                    message:customeError
                }
            };
        }

        //Handle : error while deleting user
        if rowsAffected is error {
            string customError = "Error occurred while deleting user";
            log:printError(customError, rowsAffected);
            return <http:InternalServerError>{
                body: {
                    message: customError
                }
            };
        }

        //Handle : user details not updating in db
        if rowsAffected is 0 {
            string customError = "User did not get deleted";
            log:printError(customError);
            return <http:InternalServerError>{
                body: {
                    message: customError
                }
            };
        }

        return http:NO_CONTENT;
    }

    # Search for users by name
    #
    # + name - Name user want to search
    # + return - Array of User records|InternalServerError
    resource function get users/search(@http:Query string name) returns User[]|http:InternalServerError {
        User[]|error users = database:searchUserByName(name);

        //Handle : error while searching users
        if users is error {
            string customError = "Error occurred while searching users";
            log:printError(customError, users);
            return <http:InternalServerError>{
                body: {
                    message: customError
                }
            };
        }

        return users;
    }
}