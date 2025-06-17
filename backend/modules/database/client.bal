import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerinax/java.jdbc;

# Database Client Configuration.
configurable DatabaseConfig databaseConfig = ?;

DatabaseClientConfig databaseClientConfig = {
    ...databaseConfig,
    options: {
        ssl: {
            mode: mysql:SSL_REQUIRED
        },
        connectTimeout: 10
    }
};

function initSampleDbClient() returns mysql:Client|error
=> new (...databaseClientConfig);

# Database Client.
final jdbc:Client databaseClient = check initSampleDbClient();