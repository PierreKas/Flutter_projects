import 'package:fluttertoast/fluttertoast.dart';

import 'package:pharmacy/database/selling_db/database_helper.dart';
import 'package:pharmacy/models/selling.dart';

class SellsController {
  static List<Selling> transactionsList = [];

  Future<void> addTransaction(Selling transaction, Function callback) async {
    if (transaction.productCode == null ||
        transaction.productCode!.isEmpty ||
        transaction.unitPrice == null ||
        transaction.unitPrice! <= 0 ||
        transaction.quantity == null ||
        transaction.quantity! <= 0 ||
        transaction.totalPrice == null ||
        transaction.totalPrice! <= 0 ||
        transaction.sellerPhoneNumber.isEmpty) {
      Fluttertoast.showToast(msg: 'Veuillez remplir tous les champs requis');
      return;
    }

    try {
      SellingDatabaseHelper dbHelper = SellingDatabaseHelper();
      await dbHelper.addTransactionToDB(transaction);
      transactionsList.add(transaction);
      callback();
      //getTransactions(callback);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Erreur lors de l\'ajout du produit');
    }
  }
//  Future<void> setBillCode() async {
//     final conn = await DatabaseHelper.getConnection();
//     if (conn == null) {
//       return;
//     }
//     int newDefaultBillCode = randonNum();
//     String alterSql =
//         "ALTER TABLE selling ALTER COLUMN bill_code SET DEFAULT newDefaultBillCode";
//     await conn.execute(alterSql);
//     await conn.close();
//   }

  Future<void> setBillCode() async {
    try {
      SellingDatabaseHelper dbHelper = SellingDatabaseHelper();
      await dbHelper.setBillCodeInDB();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Bill code didn\'t');
    }
  }

  // Future<String?> getLastBillCodeToDB() async {
  //   final conn = await DatabaseHelper.getConnection();
  //   if (conn == null) {
  //     return null;
  //   }

  //   const sql = '''
  //   SELECT bill_code FROM selling
  //   WHERE transaction_id = (SELECT MAX(transaction_id) FROM selling)
  // ''';

  //   try {
  //     final results = await conn.execute(sql);
  //     if (results.isNotEmpty) {
  //       final lastBillCode = results.rows.first.assoc()['bill_code'];
  //       print('Last bill_code retrieved successfully $lastBillCode');
  //       return lastBillCode;
  //     } else {
  //       print('No transactions found.');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error during SELECT operation: $e');
  //     return null;
  //   } finally {
  //     await conn.close();
  //   }
  // }

  Future<int?> getLastBillCode() async {
    int? lastBillCode;
    try {
      SellingDatabaseHelper dbHelper = SellingDatabaseHelper();
      lastBillCode = await dbHelper.getLastBillCodeToDB();
      print(lastBillCode);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Nothing was returned');
    }
    return lastBillCode;
  }

  Future<void> getSellingInfoByDate(
      DateTime sellingDate, Function(List<Selling>) callback) async {
    try {
      SellingDatabaseHelper dbHelper = SellingDatabaseHelper();
      // List<Map<String, dynamic>>? transactionsData =
      //     await dbHelper.getTransactionInfoToDbByDate(
      //         DateTime(sellingDate.year, sellingDate.month, sellingDate.day));
      // DateTime dateTime = DateTime.parse('2024-03-22 10:02:48');
      List<Map<String, dynamic>>? transactionsData =
          await dbHelper.getTransactionInfoToDbByDate(sellingDate);

      // ignore: unnecessary_null_comparison
      if (transactionsData != null && transactionsData.isNotEmpty) {
        List<Selling> transactions = transactionsData.map((transactionData) {
          print('$transactionData');
          return Selling(
            productCode: transactionData['product_code'] as String,
            sellerPhoneNumber: transactionData['seller_phone_number'] as String,
            unitPrice: (transactionData['unit_price'] is num)
                ? (transactionData['unit_price'] as num).toDouble()
                : double.tryParse(transactionData['unit_price'] as String) ??
                    0.0,
            quantity: (transactionData['quantity'] is int)
                ? transactionData['quantity'] as int
                : int.tryParse(transactionData['quantity'] as String) ?? 0,
            sellingDate: transactionData['selling_date'] != null
                ? DateTime.parse(transactionData['selling_date'] as String)
                : null,
            totalPrice: (transactionData['total_price'] is num)
                ? (transactionData['total_price'] as num).toDouble()
                : double.tryParse(transactionData['total_price'] as String) ??
                    0.0,
            productName: transactionData['product_name'] as String,
          );
        }).toList();

        callback(transactions);
        print("Controller works okay");
      } else {
        Fluttertoast.showToast(
            msg:
                'No transactions found for the date: ${DateTime(sellingDate.year, sellingDate.month, sellingDate.day)}');
      }
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(
          msg: 'Erreur lors de la récupération des transactions');
    }
  }

  Future<void> getTransactionInfoByBillCode(
      int? billCode, Function(List<Selling>) callback) async {
    try {
      SellingDatabaseHelper dbHelper = SellingDatabaseHelper();
      // billCode ??= await dbHelper.getLastBillCodeToDB();
      // print(billCode);
      List<Map<String, dynamic>>? transactionsData =
          await dbHelper.getTransactionInfoFromDbByBillCode(billCode);
      print(transactionsData);
      // ignore: unnecessary_null_comparison
      if (transactionsData != null && transactionsData.isNotEmpty) {
        List<Selling> transactions = transactionsData.map((transactionData) {
          print('Transac data for this bill code: $transactionData');
          return Selling(
            // billCode: (transactionData['bill_code'] is int)
            //     ? transactionData['bill_code'] as int
            //     : int.tryParse(transactionData['bill_code'] as String) ?? 0,
            productCode: transactionData['product_code'] as String,
            sellerPhoneNumber: transactionData['seller_phone_number'] as String,
            unitPrice: (transactionData['unit_price'] is num)
                ? (transactionData['unit_price'] as num).toDouble()
                : double.tryParse(transactionData['unit_price'] as String) ??
                    0.0,
            quantity: (transactionData['quantity'] is int)
                ? transactionData['quantity'] as int
                : int.tryParse(transactionData['quantity'] as String) ?? 0,
            sellingDate: transactionData['selling_date'] != null
                ? DateTime.parse(transactionData['selling_date'] as String)
                : null,
            totalPrice: (transactionData['total_price'] is num)
                ? (transactionData['total_price'] as num).toDouble()
                : double.tryParse(transactionData['total_price'] as String) ??
                    0.0,
            productName: transactionData['product_name'] as String,
          );
        }).toList();

        callback(transactions);
      } else {
        Fluttertoast.showToast(
            msg: 'No transactions found for the bill code: $billCode');
        print('No transactions found for the bill code: $billCode');
      }
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(
          msg: 'Erreur lors de la récupération des transactions');
    }
  }
}
