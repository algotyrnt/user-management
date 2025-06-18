# User insert type.
public type UserInsert record {|
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
public type User record {|
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