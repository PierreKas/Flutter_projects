import 'package:pharmacy/database/conn_string.dart';
import 'package:pharmacy/models/users.dart';

class UsersDatabaseHelper {
  Future<List<Map<String, dynamic>>> getUsersToDB() async {
    final conn = await DatabaseHelper.getConnection();
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
    final conn = await DatabaseHelper.getConnection();
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
