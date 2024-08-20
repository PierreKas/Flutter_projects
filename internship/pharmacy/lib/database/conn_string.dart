import 'package:mysql_client/mysql_client.dart';

class DatabaseHelper {
  // Private constructor
  DatabaseHelper._privateConstructor();

  // The single instance of the class
  static final DatabaseHelper _instance = DatabaseHelper._privateConstructor();

  // Factory method to return the single instance
  factory DatabaseHelper() {
    return _instance;
  }

  // Database connection details
  final String host = '192.168.2.10';
  final int port = 3306;
  final String username = 'root';
  final String password = 'KASANANI';
  final String databaseName = 'pharmacy_management_system_db';

  // Get a connection
  Future<MySQLConnection> getConnection() async {
    final conn = await MySQLConnection.createConnection(
      host: host,
      port: port,
      userName: username,
      password: password,
      databaseName: databaseName,
    );

    await conn.connect();
    print('DB connected successfully');
    return conn;
  }
}
