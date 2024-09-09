import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy/controllers/selling_controller.dart';
import 'package:pharmacy/models/selling.dart';
import 'package:pharmacy/views/selling/bill.dart';
import 'package:pharmacy/views/selling/daily_transactions.dart';

class SellingForm extends StatefulWidget {
  const SellingForm({super.key});

  @override
  State<SellingForm> createState() => _AddProductState();
}

class _AddProductState extends State<SellingForm> {
  final TextEditingController _productCode = TextEditingController();

  final TextEditingController _unitPrice = TextEditingController();

  final TextEditingController _totalPrice = TextEditingController();

  final TextEditingController _quantity = TextEditingController();

  final TextEditingController _sellerPhoneNumber = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _quantity.addListener(_calculateTotalPrice);
    _unitPrice.addListener(_calculateTotalPrice);
    _sellerPhoneNumber.addListener(_phono);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _productCode.dispose();
    _unitPrice.dispose();
    _totalPrice.dispose();
    _quantity.dispose();
    _sellerPhoneNumber.dispose();
    super.dispose();
  }

  String _phono() {
    String phone = '0900000000';
    return phone;
  }

  void _calculateTotalPrice() {
    int quantity = int.tryParse(_quantity.text) ?? 0;
    double unitPrice = double.tryParse(_unitPrice.text) ?? 0.0;
    double totalPrice = quantity * unitPrice;

    setState(() {
      _totalPrice.text = totalPrice.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 237, 237),
      body: Stack(
        children: [
          Positioned.fill(
              child: Center(
            child: Opacity(
              opacity: 0.2,
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'YEREMIYA PHARMACY',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromARGB(255, 73, 71, 71)),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        PopupMenuButton(
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                      onTap: () {
                                        DateTime selectedDate = DateTime.now();
                                        DateTime dateOnly = DateTime(
                                            selectedDate.year,
                                            selectedDate.month,
                                            selectedDate.day);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DailyTransactionsList(
                                                    sellingDate: dateOnly,
                                                  )),
                                        );
                                      },
                                      child: const Text('Ventes journalières')),
                                  PopupMenuItem(
                                      onTap: () async {
                                        int? billCode;

                                        billCode = await SellsController()
                                            .getLastBillCode();
                                        Fluttertoast.showToast(
                                            msg: '$billCode');
                                        print(billCode);
                                        if (billCode != null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Bill(
                                                      billCode: billCode,
                                                    )),
                                          );
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  'Cannot proceed because bill code is null');
                                        }
                                      },
                                      child: const Text('Voir la facture')),
                                ])
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Enregistrer les ventes sur via cette page',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 200.0),
                      child: Text(
                        'Code du produit',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _productCode,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        // labelText: 'Tél',
                        // labelStyle: const TextStyle(
                        //   color: Color.fromARGB(255, 177, 223, 179),
                        // ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(80.0),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: const Icon(
                          Icons.qr_code,
                          color: Colors.blue,
                        ),
                        //floatingLabelBehavior: FloatingLabelBehavior.never
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 200.0),
                      child: Text(
                        'Prix unitaire',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _unitPrice,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        //labelText: 'Mot de passe',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(80.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.monetization_on_outlined,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 250.0),
                      child: Text(
                        'Quantité',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _quantity,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        // labelText: 'Point de vente',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(80.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.numbers, // Adjust icon as needed
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 230.0),
                      child: Text(
                        'Prix total',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _totalPrice,
                      cursorColor: Colors.grey,
                      enabled: false,
                      decoration: InputDecoration(
                        //labelText: 'Noms',

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(80.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.monetization_on, // Adjust icon as needed
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 150.0),
                      child: Text(
                        'Numéro du revendeur',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _sellerPhoneNumber,
                      cursorColor: Colors.grey,
                      enabled: true,
                      decoration: InputDecoration(
                        // hintText: '0900000000',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(80.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.phone, // Adjust icon as needed
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String productCode = _productCode.text;
                        String unitPriceStr = _unitPrice.text;
                        String quantityStr = _quantity.text;
                        String totalPriceStr = _totalPrice.text;
                        String sellerPhoneNumber = _sellerPhoneNumber.text;

                        int quantity = int.tryParse(quantityStr) ?? 0;
                        double unitPrice = double.tryParse(unitPriceStr) ?? 0.0;
                        double totalPrice =
                            double.tryParse(totalPriceStr) ?? 0.0;

                        Selling newTransaction = Selling(
                            productCode: productCode,
                            unitPrice: unitPrice,
                            totalPrice: totalPrice,
                            sellerPhoneNumber: sellerPhoneNumber,
                            quantity: quantity);
                        SellsController().addTransaction(newTransaction, () {});
                        _sellerPhoneNumber.clear();
                        _productCode.clear();
                        _totalPrice.clear();
                        _unitPrice.clear();
                        _quantity.clear();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: const Text(
                        'Ajouter',
                        style: TextStyle(
                          color: Color.fromARGB(255, 238, 237, 237),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
