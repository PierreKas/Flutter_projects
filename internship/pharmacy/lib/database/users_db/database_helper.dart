import 'package:mysql_client/mysql_client.dart';
import 'package:pharmacy/controllers/users_controller.dart';
import 'package:pharmacy/models/users.dart';

class DatabaseHelper {
  final String host = '192.168.2.10';
  final int port = 3306;
  final String username = 'root';
  final String password = 'KASANANI';
  final String databaseName = 'pharmacy_management_system_db';
  // late User userr;
  // String phone= userr.phoneNumber;

  Future<MySQLConnection> _getConnection() async {
    try {
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
    } catch (e) {
      print('Error connecting to the database: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getUsersToDB() async {
    final conn = await _getConnection();
    const sql = 'SELECT * FROM user';

    try {
      final results = await conn.execute(sql);
      final users = results.rows.map((row) => row.assoc()).toList();

      print('User retried successfully');
      return users;
    } catch (e) {
      print('Error during SELECT operation: $e');
      return [];
    } finally {
      await conn.close();
    }
  }
  // Future<List<Map<String, dynamic>>> getUserInfoToDB(User user) async {
  //   final conn = await _getConnection();
  //   final sql = 'SELECT * FROM user WHERE phone_number='"${user.phoneNumber}"'';

  //   try {
  //     final results = await conn.execute(sql);
  //     final users = results.rows.map((row) => row.assoc()).toList();

  //     print('User retried successfully');
  //     return users;
  //   } catch (e) {
  //     print('Error during SELECT operation: $e');
  //     return [];
  //   } finally {
  //     await conn.close();
  //   }
  // }
  Future<void> addUserToDB(User user) async {
    final conn = await _getConnection();
    // await conn.execute(
    //     'INSERT INTO user(Full_name,phone_number, role, selling_point, pwd, user_state) VALUES (?,?,?,?,?,?)',
    //     {
    //       'Full_name': user.fullName,
    //       'phone_number': user.phoneNumber,
    //       'role': user.role,
    //       'selling_point': user.sellingPoint,
    //       'pwd': user.password,
    //       'user_state': null
    //     }
    //     );
    //await conn.close();
    final sql = '''
    INSERT INTO user (Full_name, phone_number, role, selling_point, pwd, user_state) 
    VALUES (
      '${user.fullName}', 
      '${user.phoneNumber}', 
      '${user.role}', 
      '${user.sellingPoint}', 
      '${user.password}', 
      NULL
    )
  ''';

    try {
      await conn.execute(sql);
      print('User added successfully');
    } catch (e) {
      print('Error during INSERT operation: $e');
    } finally {
      await conn.close();
    }
  }
}
