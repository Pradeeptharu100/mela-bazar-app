import 'package:flutter/material.dart';
import 'package:melebazaar_app/features/product_detail/model/product_model.dart';

class ProductInfo extends StatelessWidget {
  final Product product;

  const ProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.name, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Row(
          children: [
            Text('NPR.${product.price.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Text('NPR.${product.strikePrice.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 16, decoration: TextDecoration.lineThrough)),
            const SizedBox(width: 8),
            Text(
                '${((product.strikePrice - product.price) / product.strikePrice * 100).toStringAsFixed(0)}% off',
                style: const TextStyle(color: Colors.green)),
          ],
        ),
      ],
    );
  }
}
