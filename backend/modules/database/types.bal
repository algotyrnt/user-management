import ballerina/sql;

# [Configurable] database configs.
type DatabaseConfig record {|
    # Database User 
    string user;
    # Database Password
    string password;
    # Database Name
    string database;
    # Database Host
    string host;
    # Database port
    int port;
|};

# [Database]New User type.
public type NewUser record {|
    # User's first name
    @sql:Column {name: "first_name"}
    string firstName;
    # User's last name
    @sql:Column {name: "last_name"}
    string lastName;
    # User's mobile_number
    @sql:Column {name: "mobile_number"}
    string mobileNumber;
    # User's email
    string email;
|};

# [Database]User type.
public type User record {|
    # Unique ID of the user
    int id;
    # User's first name
    @sql:Column {name: "first_name"}
    string firstName;
    # User's last name
    @sql:Column {name: "last_name"}
    string lastName;
    # User's mobile_number
    @sql:Column {name: "mobile_number"}
    string mobileNumber;
    # User's email
    string email;
|};