import 'package:mysql_client/mysql_client.dart';
import 'package:pharmacy/controllers/users_controller.dart';
import 'package:pharmacy/models/selling.dart';
import 'package:pharmacy/models/users.dart';

class DatabaseHelper {
  final String host = '192.168.0.173';
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

  Future<List<Map<String, dynamic>>> getTransactionsToDB() async {
    final conn = await _getConnection();
    const sql = 'SELECT * FROM selling';

    try {
      final results = await conn.execute(sql);
      final transactions = results.rows.map((row) => row.assoc()).toList();

      print('Transactions retrieved successfully');
      return transactions;
    } catch (e) {
      print('Error during SELECT operation: $e');
      return [];
    } finally {
      await conn.close();
    }
  }

  Future<void> addItemToDB(Selling selling) async {
    final conn = await _getConnection();

    final sql = '''
    INSERT INTO selling (product_code,unit_price,quantity,seller_phone_number,total_price)
    VALUES (
      '${selling.productCode}', 
      '${selling.unitPrice}', 
      '${selling.quantity}', 
      '${selling.sellerPhoneNumber}', 
      '${selling.totalPrice}', 
    )
  ''';

    try {
      await conn.execute(sql);
      print('Item added successfully');
    } catch (e) {
      print('Error during INSERT operation: $e');
    } finally {
      await conn.close();
    }
  }
}
