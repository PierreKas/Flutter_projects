import 'package:mysql_client/mysql_client.dart';
import 'package:pharmacy/models/products.dart';
import 'package:pharmacy/models/users.dart';
import 'package:pharmacy/database/conn_string.dart';

class DatabaseHelper {
  final String host = '192.168.2.10';
  final int port = 3306;
  final String username = '%';
  final String password = 'KASANANI';
  final String databaseName = 'pharmacy_management_system_db';

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

  Future<List<Map<String, dynamic>>> getProductsrsToDB() async {
    final conn = await _getConnection();
    const sql = 'SELECT * FROM products';

    try {
      final results = await conn.execute(sql);
      final products = results.rows.map((row) => row.assoc()).toList();

      print('Products retried successfully');
      return products;
    } catch (e) {
      print('Error during SELECT operation: $e');
      return [];
    } finally {
      await conn.close();
    }
  }

  Future<void> addProductToDB(Product product) async {
    final conn = await _getConnection();
    final sql = '''
    INSERT INTO products (product_code, product_name, purchase_price, quantity, expiry_date) 
    VALUES (
      '${product.productCode}', 
      '${product.productName}', 
      '${product.purchasePrice}', 
      '${product.quantity}', 
      '${product.expiryDate}', 
      
    )
  ''';

    try {
      await conn.execute(sql);
      print('product added successfully');
    } catch (e) {
      print('Error during INSERT operation: $e');
    } finally {
      await conn.close();
    }
  }
}
