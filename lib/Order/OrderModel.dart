class Order {
  final int id;
  final int productId;
  final int customerId;
  final String? customerName;
  final int quantity;
  final double totalPrice;
  final double advancePayment;
  final double remainingPayment;
  final String status;
  final String? reason;
  final DateTime? returnDate;
  final int shippingId;
  final DateTime createdOnUTC;
  final String? createdStringDate;
  final String? productName;
  final String paymentType;
  final String shippingAddress;
  final int paymentId;
  final bool cashOnDelivery;
  final List<dynamic> cartDTOs;
  final List<dynamic> saleOrderProductMappings;
  final double? taxRate;
  final double? withholdingTax;
  final String? cardholderName;
  final String? cardNumber;
  final String? expiry;
  final int cvc;
  final bool isReturnDateValid;

  const Order({
    required this.id,
    required this.productId,
    required this.customerId,
    required this.customerName,
    required this.quantity,
    required this.totalPrice,
    required this.advancePayment,
    required this.remainingPayment,
    required this.status,
    required this.reason,
    required this.returnDate,
    required this.shippingId,
    required this.createdOnUTC,
    required this.createdStringDate,
    required this.productName,
    required this.paymentType,
    required this.shippingAddress,
    required this.paymentId,
    required this.cashOnDelivery,
    required this.cartDTOs,
    required this.saleOrderProductMappings,
    required this.taxRate,
    required this.withholdingTax,
    required this.cardholderName,
    required this.cardNumber,
    required this.expiry,
    required this.cvc,
    required this.isReturnDateValid,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      productId: json['productId'] ?? 0,
      customerId: json['customerId'] ?? 0,
      customerName: json['customerName'],
      quantity: json['quantity'] ?? 0,
      totalPrice: json['totalPrice'] ?? 0.0,
      advancePayment: json['advancePayment'] ?? 0.0,
      remainingPayment: json['remainingPayment'] ?? 0.0,
      status: json['status'] ?? '',
      reason: json['reason'],
      returnDate: json['returnDate'] != null ? DateTime.parse(json['returnDate']) : null,
      shippingId: json['shippingId'] ?? 0,
      createdOnUTC: json['createdOnUTC'] != null ? DateTime.parse(json['createdOnUTC']) : DateTime.now(),
      createdStringDate: json['createdStringDate'],
      productName: json['productName'],
      paymentType: json['paymentType'] ?? '',
      shippingAddress: json['shippingAddress'] ?? '',
      paymentId: json['paymentId'] ?? 0,
      cashOnDelivery: json['cashOnDelivery'] ?? false,
      cartDTOs: json['cartDTOs'],
      saleOrderProductMappings: json['saleOrderProductMappings'],
      taxRate: json['taxRate'],
      withholdingTax: json['withHoldingTax'],
      cardholderName: json['cardholderName'],
      cardNumber: json['cardNumber'],
      expiry: json['expiry'],
      cvc: json['cvc'] ?? 0,
      isReturnDateValid: json['isReturnDateIsValde'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "customerId": customerId,
        "customerName": customerName,
        "quantity": quantity,
        "totalPrice": totalPrice,
        "advancePayment": advancePayment,
        "remainingPayment": remainingPayment,
        "status": status,
        "reason": reason,
        "returnDate": returnDate?.toIso8601String(),
        "shippingId": shippingId,
        "createdOnUTC": createdOnUTC.toIso8601String(),
        "createdStringDate": createdStringDate,
        "productName": productName,
        "paymentType": paymentType,
        "shippingAddress": shippingAddress,
        "paymentId": paymentId,
        "cashOnDelivery": cashOnDelivery,
        "cartDTOs": cartDTOs,
        "saleOrderProductMappings": saleOrderProductMappings,
        "taxRate": taxRate,
        "withHoldingTax": withholdingTax,
        "cardholderName": cardholderName,
        "cardNumber": cardNumber,
        "expiry": expiry,
        "cvc": cvc,
        "isReturnDateIsValde": isReturnDateValid,
      };
}
