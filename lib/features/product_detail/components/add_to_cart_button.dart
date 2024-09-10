import 'package:flutter/material.dart';
import 'package:melebazaar_app/common/custom_button.dart';
import 'package:melebazaar_app/common/pt_colors.dart';

class AddToCartButton extends StatelessWidget {
  final VoidCallback onClick;

  const AddToCartButton({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      label: 'Add to Cart',
      onClick: onClick,
      buttonColor: PTColor.secondary,
    );
  }
}
