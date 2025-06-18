import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerinax/java.jdbc;

# Database Client Configuration.
configurable DatabaseConfig databaseConfig = ?;

function initSampleDbClient() returns mysql:Client|error
=> new (...databaseConfig);

# Database Client.
final jdbc:Client databaseClient = check initSampleDbClient();