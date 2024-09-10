import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melebazaar_app/common/pt_colors.dart';
import 'package:melebazaar_app/features/product_detail/model/product_model.dart';
import 'package:melebazaar_app/features/product_detail/provider/product_provider.dart';

class VariantSelection extends StatelessWidget {
  final ProductProvider productProvider;
  final Product product;

  const VariantSelection(
      {super.key, required this.productProvider, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: product.variants.length,
      itemBuilder: (context, innerIndex) {
        final variants = product.variants[innerIndex];
        final variantType = variants.type.name;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(variantType,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                )),
            const SizedBox(height: 10),
            Row(
              children: List.generate(
                variants.values.length,
                (index) {
                  final isSelected =
                      productProvider.getSelectedIndex(variantType) == index;
                  final variantValues = variants.values[index];
                  return GestureDetector(
                    onTap: () {
                      productProvider.setSelectedIndex(variantType, index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? PTColor.primary
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: PTColor.primary),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Center(
                          child: Text(
                            variantValues.value,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        );
      },
    );
  }
}
