import 'package:fluttertoast/fluttertoast.dart';

import 'package:pharmacy/database/products_db/database_helper.dart';
import 'package:pharmacy/models/products.dart';

class ProductsController {
  static List<Product> productsList = [];

  Future<void> addProduct(Product product, Function callback) async {
    if (product.productCode.isEmpty || product.productName.isEmpty) {
      Fluttertoast.showToast(msg: 'Complète le nom du produit et son code');
      return;
    }

    try {
      ProductDatabaseHelper dbHelper = ProductDatabaseHelper();
      await dbHelper.addProductToDB(product);
      productsList.add(product);
      callback();
      getProducts(callback);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Erreur lors de l\'ajout du produit');
    }
  }

  Future<void> deleteProduct(String productCode, Function callback) async {
    try {
      ProductDatabaseHelper dbHelper = ProductDatabaseHelper();
      bool isDeleted = await dbHelper.deleteProductToDB(productCode);
      if (isDeleted) {
        productsList
            .removeWhere((product) => product.productCode == productCode);
        callback();
      } else {
        Fluttertoast.showToast(
            msg: 'Aucun produit trouvé avec le code: $productCode');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Erreur lors de la suppression du produit');
    }
  }

  Future<void> updateProduct(Product product, Function callback) async {
    if (product.productCode.isEmpty ||
        product.productName.isEmpty ||
        product.purchasePrice <= 0 ||
        product.quantity <= 0 ||
        product.expiryDate == null) {
      Fluttertoast.showToast(msg: 'Veuillez remplir tous les champs requis');
      return;
    }
    try {
      ProductDatabaseHelper dbHelper = ProductDatabaseHelper();
      await dbHelper.updateProductInDB(product);
      int index =
          productsList.indexWhere((p) => p.productCode == product.productCode);
      if (index != -1) {
        productsList[index] = product;
      }
      callback();
      getProducts(callback);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Erreur lors de la mise à jour du produit');
    }
  }

  Future<void> getProducts(Function callback) async {
    try {
      ProductDatabaseHelper dbHelper = ProductDatabaseHelper();
      List<Map<String, dynamic>> productsData =
          await dbHelper.getProductsToDB();

      // usersList.clear();
      print('Raw product data: $productsData');

      productsList = productsData.map((productData) {
        return Product(
          productCode: productData['product_code'] as String,
          productName: productData['product_name'] as String,
          purchasePrice: (productData['purchase_price'] is num)
              ? (productData['purchase_price'] as num).toDouble()
              : double.tryParse(productData['purchase_price'] as String) ?? 0.0,
          quantity: (productData['quantity'] is int)
              ? productData['quantity'] as int
              : int.tryParse(productData['quantity'] as String) ?? 0,
          expiryDate: productData['expiry_date'] != null
              ? DateTime.parse(productData['expiry_date'] as String)
              : null,
        );
      }).toList();
      print('Mapped products: $productsList');

      callback();
      Fluttertoast.showToast(msg: 'Produits récupérés avec succès');
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(
          msg: 'Erreur lors de la récupération des produits');
    }
  }

  Future<void> getProductInfo(String productCode, Function callback) async {
    try {
      ProductDatabaseHelper dbHelper = ProductDatabaseHelper();
      Map<String, dynamic>? productData =
          await dbHelper.getProductInfoToDB(productCode);

      // usersList.clear();
      print('Raw product data: $productData');

      if (productData != null) {
        Product product = Product(
          productCode: productData['product_code'] as String,
          productName: productData['product_name'] as String,
          purchasePrice: (productData['purchase_price'] is num)
              ? (productData['purchase_price'] as num).toDouble()
              : double.tryParse(productData['purchase_price'] as String) ?? 0.0,
          quantity: (productData['quantity'] is int)
              ? productData['quantity'] as int
              : int.tryParse(productData['quantity'] as String) ?? 0,
          expiryDate: productData['expiry_date'] != null
              ? DateTime.parse(productData['expiry_date'] as String)
              : null,
        );
        callback(product);
      } else {
        Fluttertoast.showToast(
            msg: 'No product found with the code: $productCode');
      }
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(
          msg: 'Erreur lors de la récupération des produits');
    }
  }
}
