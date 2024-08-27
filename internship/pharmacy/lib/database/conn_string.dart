import 'package:mysql_client/mysql_client.dart';

class DatabaseHelper {
  // Database connection details
  static String host = '192.168.2.11';
  static int port = 3306;
  static String username = 'root';
  static String password = 'KASANANI';
  static String databaseName = 'pharmacy_management_system_db';
  static MySQLConnection? conn;
  // Get a connection
  static Future<MySQLConnection> getConnection() async {
    if (conn != null && conn?.connected == true) return conn!;
    conn = await MySQLConnection.createConnection(
      host: host,
      port: port,
      userName: username,
      password: password,
      databaseName: databaseName,
    );

    await conn!.connect();
    print('DB connected successfully');
    return conn!;
  }
}
