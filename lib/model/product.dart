import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String product;
  final int amount;
  final double purchaseValue;
  final double saleValue;
  final double profit;
  final DateTime date;

  Product({
    @required this.id,
    @required this.product,
    @required this.amount,
    @required this.purchaseValue,
    @required this.saleValue,
    @required this.profit,
    @required this.date,
  });
}
