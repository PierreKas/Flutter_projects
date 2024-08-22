import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:pharmacy/models/products.dart';

class DatabaseHelper {
  final String host = '192.168.0.173';
  final int port = 3306;
  final String username = 'root';
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

  Future<List<Map<String, dynamic>>> getProductsToDB() async {
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

  Future<Map<String, dynamic>?> getProductInfoToDB(String productCode) async {
    final conn = await _getConnection();

    const sql = 'SELECT * FROM products WHERE product_code= :productCode';

    try {
      final results = await conn.execute(sql, {'productCode': productCode});
      if (results.rows.isNotEmpty) {
        final product = results.rows.first.assoc();
        print('Product info retrieved successfully');
        Fluttertoast.showToast(msg: 'Product info retrieved successfully');
        return product;
      } else {
        print('No product found with the code :$productCode');
        Fluttertoast.showToast(
            msg: 'No product found with the code :$productCode');
        return null;
      }
    } catch (e) {
      print('Error during SELECT operation: $e');
      return null;
    } finally {
      await conn.close();
    }
  }

  Future<bool> deleteProductToDB(String productCode) async {
    final conn = await _getConnection();

    const sql = 'DELETE FROM products WHERE product_code= :productCode';

    try {
      final results = await conn.execute(sql, {'productCode': productCode});
      if (results.rows.isNotEmpty) {
        final product = results.rows.first.assoc();
        print('Product deleted successfully');
        Fluttertoast.showToast(msg: 'Product deleted successfully');
        return true;
      } else {
        print('No product found with the code :$productCode');
        Fluttertoast.showToast(
            msg: 'No product found with the code :$productCode');
        return false;
      }
    } catch (e) {
      print('Error during DELETE operation: $e');
      return false;
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
      '${product.expiryDate}'
    )
  ''';

    try {
      await conn.execute(sql);
      print('product added successfully');
      Fluttertoast.showToast(msg: 'Produit ajouté');
    } catch (e) {
      print('Error during INSERT operation: $e');
    } finally {
      await conn.close();
    }
  }

  Future<Map<String, dynamic>?> updateProductInDB(Product product) async {
    final conn = await _getConnection();

    final sql = '''
  UPDATE products 
  SET 
    product_name = '${product.productName}', 
    purchase_price = '${product.purchasePrice}', 
    quantity = '${product.quantity}', 
    expiry_date = '${product.expiryDate}'
  WHERE 
    product_code = '${product.productCode}'
  ''';
    try {
      final results = await conn.execute(sql);
      if (results.affectedRows.toInt() > 0) {
        print('Product updated successfully');
        Fluttertoast.showToast(msg: 'Product updated successfully');
      } else {
        print('No product found with the code :${product.productCode}');
        Fluttertoast.showToast(
            msg: 'No product found with the code :${product.productCode}');
        return null;
      }
    } catch (e) {
      print('Error during UPDATE operation: $e');
      return null;
    } finally {
      await conn.close();
    }
    return null;
  }
}
