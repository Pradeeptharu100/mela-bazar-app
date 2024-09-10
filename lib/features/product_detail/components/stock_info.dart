import 'package:flutter/material.dart';

class StockInfo extends StatelessWidget {
  final int stock;

  const StockInfo({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    return Text(
      stock > 0 ? 'In Stock: $stock' : 'Out of Stock',
      style: TextStyle(
        fontSize: 16,
        color: stock > 0 ? Colors.green : Colors.red,
      ),
    );
  }
}
