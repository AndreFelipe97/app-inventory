import 'package:flutter/foundation.dart';

class Sale {
  final String product;
  final double price;
  final int amount;
  final DateTime date;

  Sale({
    @required this.product,
    @required this.price,
    @required this.amount,
    @required this.date,
  });
}
