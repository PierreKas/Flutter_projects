class Selling {
  int? billCode;
  String? productCode;
  double? unitPrice;
  int? quantity;
  DateTime? sellingDate;
  double? totalPrice;
  String sellerPhoneNumber;
  int? transactionId;
  String? productName;

  Selling(
      {this.billCode,
      this.productCode,
      this.unitPrice,
      this.quantity,
      this.sellingDate,
      this.totalPrice,
      required this.sellerPhoneNumber,
      this.transactionId,
      this.productName});

  factory Selling.fromJson(Map<String, dynamic> json) {
    return Selling(
      billCode: json['bill_code'],
      productCode: json['product_code'],
      unitPrice: json['unit_price'],
      quantity: json['quantity'],
      sellingDate: json['selling_date'] != null
          ? DateTime.parse(json['selling_date'])
          : null,
      totalPrice: json['total_price'],
      sellerPhoneNumber: json['seller_phone_number'],
      transactionId: json['TransactionId'],
      productName: json['product_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bill_code': billCode,
      'product_code': productCode,
      'unit_price': unitPrice,
      'quantity': quantity,
      'selling_date': sellingDate?.toIso8601String(),
      'total_price': totalPrice,
      'seller_phone_number': sellerPhoneNumber,
      'TransactionId': transactionId,
      'product_name': productName,
    };
  }
}
