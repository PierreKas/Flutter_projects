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

  // Future<void> deleteSelling(String SellingCode, Function callback) async {
  //   try {
  //     DatabaseHelper dbHelper = DatabaseHelper();
  //     bool isDeleted = await dbHelper.deleteSellingToDB(SellingCode);
  //     if (isDeleted) {
  //       SellingsList
  //           .removeWhere((Selling) => Selling.SellingCode == SellingCode);
  //       callback();
  //     } else {
  //       Fluttertoast.showToast(
  //           msg: 'Aucun produit trouvé avec le code: $SellingCode');
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: 'Erreur lors de la suppression du produit');
  //   }
  // }

  // Future<void> updateSelling(Selling Selling, Function callback) async {
  //   if (Selling.SellingCode.isEmpty ||
  //       Selling.SellingName.isEmpty ||
  //       Selling.purchasePrice <= 0 ||
  //       Selling.quantity <= 0 ||
  //       Selling.expiryDate == null) {
  //     Fluttertoast.showToast(msg: 'Veuillez remplir tous les champs requis');
  //     return;
  //   }
  //   try {
  //     DatabaseHelper dbHelper = DatabaseHelper();
  //     await dbHelper.updateSellingInDB(Selling);
  //     int index =
  //         SellingsList.indexWhere((p) => p.SellingCode == Selling.SellingCode);
  //     if (index != -1) {
  //       SellingsList[index] = Selling;
  //     }
  //     callback();
  //     getSellings(callback);
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: 'Erreur lors de la mise à jour du produit');
  //   }
  // }

  Future<void> getTransactions(Function callback) async {
    try {
      SellingDatabaseHelper dbHelper = SellingDatabaseHelper();
      List<Map<String, dynamic>> TransactionsData =
          await dbHelper.getTransactionsToDB();

      // usersList.clear();
      print('Raw Selling data: $TransactionsData');

      transactionsList = TransactionsData.map((TransactionData) {
        return Selling(
          productCode: TransactionData['product_code'] as String,
          sellerPhoneNumber: TransactionData['seller_phone_number'] as String,
          unitPrice: (TransactionData['unit_price'] is num)
              ? (TransactionData['unit_price'] as num).toDouble()
              : double.tryParse(TransactionData['unit_price'] as String) ?? 0.0,
          quantity: (TransactionData['quantity'] is int)
              ? TransactionData['quantity'] as int
              : int.tryParse(TransactionData['quantity'] as String) ?? 0,
          sellingDate: TransactionData['selling_date'] != null
              ? DateTime.parse(TransactionData['selling_date'] as String)
              : null,
          totalPrice: (TransactionData['total_price'] is num)
              ? (TransactionData['total_price'] as num).toDouble()
              : double.tryParse(TransactionData['total_price'] as String) ??
                  0.0,
        );
      }).toList();

      print('Mapped Transactions: $transactionsList');

      callback();
      Fluttertoast.showToast(msg: 'Transactions récupérées avec succès');
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(
          msg: 'Erreur lors de la récupération des transactions');
    }
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
}
