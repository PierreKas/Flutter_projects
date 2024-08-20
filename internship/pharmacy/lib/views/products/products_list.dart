import 'package:flutter/material.dart';
import 'package:pharmacy/controllers/products_controller.dart';
import 'package:pharmacy/models/products.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() async {
    await ProductsController().getProducts(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Center(
          child: Opacity(
            opacity: 0.3,
            child: SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
                'assets/logo-no-background.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        )),
        ListView.builder(
          itemCount: ProductsController.productsList.length,
          itemBuilder: (context, index) {
            Product product = ProductsController.productsList[index];

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(product.productName),
                    Text(product.purchasePrice as String),
                    Text(product.quantity as String),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
