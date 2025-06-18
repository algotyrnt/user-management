import ballerina/sql;
import ballerinax/mysql;

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
    # Database connection pool
    sql:ConnectionPool connectionPool;
|};

# Database config record.
type DatabaseClientConfig record {|
    *DatabaseConfig;
    # Additional configurations related to the MySQL database connection
    mysql:Options? options;
|};

# [Database]User insert type.
type UserInsert record {|
    # User's first name
    string firstName;
    # User's last name
    string lastName;
    # User's mobile_number
    string mobileNumber;
    # User's email
    string email;
|};

# [Database]User type.
type User record {|
    # Unique ID of the user
    int id;
    # User's first name
    string firstName;
    # User's last name
    string lastName;
    # User's mobile_number
    string mobileNumber;
    # User's email
    string email;
|};