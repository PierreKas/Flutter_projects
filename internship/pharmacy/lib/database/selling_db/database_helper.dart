import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy/database/conn_string.dart';
import 'package:pharmacy/models/selling.dart';

class SellingDatabaseHelper {
  Future<List<Map<String, dynamic>>> getTransactionsToDB() async {
    final conn = await DatabaseHelper.getConnection();
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

  Future<List<Map<String, dynamic>>> getTransactionInfoToDbByDate(
      DateTime sellingDate) async {
    final conn = await DatabaseHelper.getConnection();
    String formattedDate =
        "${sellingDate.year}-${sellingDate.month.toString().padLeft(2, '0')}-${sellingDate.day.toString().padLeft(2, '0')}";

    String sql =
        "SELECT * FROM selling WHERE selling_date BETWEEN '$formattedDate 00:00:00' AND '$formattedDate 23:59:59'";

    try {
      final results = await conn.execute(sql);
      if (results.rows.isNotEmpty) {
        final transactions = results.rows.map((row) => row.assoc()).toList();
        print('Transactions info retrieved successfully');
        Fluttertoast.showToast(msg: 'Transactions info retrieved successfully');
        //  print(transactions);
        return transactions;
      } else {
        print("No transaction found with the date :$sellingDate ");
        Fluttertoast.showToast(
            msg: 'No transaction found with the date :$sellingDate');
        return [];
      }
    } catch (e) {
      print('Error during SELECT operation: $e');
      return [];
    } finally {
      await conn.close();
    }
  }

  Future<void> addTransactionToDB(Selling selling) async {
    final conn = await DatabaseHelper.getConnection();

    final sql = '''
    INSERT INTO selling (product_code,unit_price,quantity,total_price,seller_phone_number)
    VALUES (
      '${selling.productCode}', 
      '${selling.unitPrice}', 
      '${selling.quantity}', 
      '${selling.totalPrice}', 
      '${selling.sellerPhoneNumber}'
    )
  ''';

    try {
      await conn.execute(sql);
      print('Transaction made successfully');
      Fluttertoast.showToast(msg: 'La transaction a réussi');
    } catch (e) {
      print('Error during INSERT operation: $e');
      Fluttertoast.showToast(msg: 'Tes données contiennent une erreur');
    } finally {
      await conn.close();
    }
  }
}
