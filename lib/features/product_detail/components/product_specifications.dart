import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melebazaar_app/features/product_detail/model/product_model.dart';

class ProductSpecifications extends StatelessWidget {
  final Product product;

  const ProductSpecifications({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Specifications', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        ...product.specification.map((spec) => Container(
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  Text(
                    '${spec.type} -',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(spec.value),
                ],
              ),
            )),
      ],
    );
  }
}
