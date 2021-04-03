import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String product;
  final double value;
  final DateTime date;

  Product({
    @required this.id,
    @required this.product,
    @required this.value,
    @required this.date,
  });
}
