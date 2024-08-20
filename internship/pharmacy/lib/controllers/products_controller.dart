import 'package:fluttertoast/fluttertoast.dart';

import 'package:pharmacy/database/products_db/database_helper.dart';
import 'package:pharmacy/models/products.dart';

class ProductsController {
  static List<Product> productsList = [];

  Future<void> addProduct(Product product, Function callback) async {
    if (product.productCode.isEmpty ||
        product.productName == null ||
        product.productName!.isEmpty) {
      Fluttertoast.showToast(msg: 'Complète le nom du produit et son code');
      return;
    }

    try {
      DatabaseHelper dbHelper = DatabaseHelper();
      await dbHelper.addProductToDB(product);
      productsList.add(product);
      callback();

      Fluttertoast.showToast(msg: 'Produit ajouté');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Erreur lors de l\'ajout du produit');
    }
  }

  Future<void> getProducts(Function callback) async {
    try {
      DatabaseHelper dbHelper = DatabaseHelper();
      List<Map<String, dynamic>> productsData =
          await dbHelper.getProductsrsToDB();

      // usersList.clear();
      productsList = productsData.map((productData) {
        return Product(
          productCode: productData['product_code'],
          productName: productData['product_name'],
          purchasePrice: productData['purchase_price'],
          quantity: productData['quantity'],
          expiryDate: productData['expiry_date'],
        );
      }).toList();

      callback();
      Fluttertoast.showToast(msg: 'Produits récupérés avec succès');
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Erreur lors de la récupération des produits');
    }
  }
}
