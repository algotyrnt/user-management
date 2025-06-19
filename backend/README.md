# USER MANAGEMENT APP BACKEND

## Version: 1

#### Get user by Id
GET http://localhost:9090/user-management/users/1

#### Get all the users
GET http://localhost:9090/user-management/users

#### Creat a user
POST http://localhost:9090/user-management/users
content-type: application/json
```json
{
    "firstName": "User",
	"lastName": "One",
	"mobileNumber": "0771111111",
	"email": "user-one@user-management"
}
```

#### Update a user
PUT http://localhost:9090/user-management/users
content-type: application/json
```json
{
	"id": 3,
    "firstName": "User",
	"lastName": "Edited",
	"mobileNumber": "0771111111",
	"email": "user-one-edited@tyrnt.co"
}
```

#### Delete user by Id
DELETE http://localhost:9090/user-management/users/3