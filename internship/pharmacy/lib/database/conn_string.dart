import 'package:mysql_client/mysql_client.dart';

class DatabaseHelper {
  // Database connection details
  // static String host = '192.168.2.19';
  // static int port = 3306;
  // static String username = 'root';
  // static String password = 'KASANANI';
  // static String databaseName = 'pharmacy_management_system_db';

  static String host = 'sql5.freesqldatabase.com';
  static int port = 3306;
  static String username = 'sql5730314';
  static String password = 'PYW4dalp7b';
  static String databaseName = 'sql5730314';
  /**
   * =  Host: sql5.freesqldatabase.com
=  Database name: sql5730314
=  Database user: sql5730314
=  Database password: PYW4dalp7b
=  Port number: 3306
   */
  static MySQLConnection? conn;
  // Get a connection
  static Future<MySQLConnection?> getConnection() async {
    try {
      if (conn != null && conn?.connected == true) return conn!;
      conn = await MySQLConnection.createConnection(
        host: host,
        port: port,
        userName: username,
        password: password,
        databaseName: databaseName,
        secure: false,
      );

      await conn!.connect();
      print('DB connected successfully');
      return conn!;
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> closeConnection() async {
    if (conn != null && conn!.connected) {
      try {
        await conn!.close();
        print('DB connection closed successfully');
      } catch (e) {
        print('Error closing DB connection: $e');
      }
    } else {
      print('Connection is not established or already closed.');
    }
  }
}
