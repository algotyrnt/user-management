import ballerina/http;
import ballerina/test;

http:Client testClient = check new ("http://localhost:9090/user-management");

# Test get user.
#
# + return - return error if so
@test:Config {}
public function testGetUsers() returns error? {
    http:Response response = check testClient->get("/users");
    test:assertEquals(response.statusCode, 200, msg = "Status code should be 200");
}

# Test create user.
#
# + return - return error if so
@test:Config {}
public function testCreateUser() returns error? {
    json payload = {"firstName": "Test", "lastName": "User", "mobileNumber": "0881111111" , "email": "test-user@user-management"};
    http:Response response = check testClient->post("/users", payload);
    test:assertEquals(response.statusCode, 201, msg = "User should be created");
}

# Test get user by id.
#
# + return - return error if so
@test:Config {}
public function testGetUserById() returns error? {
    http:Response response = check testClient->get("/users/1");
    test:assertEquals(response.statusCode, 200, msg = "Should return user with ID 1");
}

# Test update user.
#
# + return - return error if so
@test:Config {}
public function testUpdateUser() returns error? {
    json payload = {"id": 1, "firstName": "Update", "lastName": "User", "mobileNumber": "0882222222" , "email": "test-user-update@user-management"};
    http:Response response = check testClient->put("/users", payload);
    test:assertEquals(response.statusCode, 200, msg = "User should be updated");
}

# Test delete user.
#
# + return - return error if so
@test:Config {}
public function testDeleteUser() returns error? {
    http:Response response = check testClient->delete("/users/2");
    test:assertEquals(response.statusCode, 204, msg = "User should be deleted");
}
