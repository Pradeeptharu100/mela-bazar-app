import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melebazaar_app/common/pt_colors.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  String? label;
  Function onClick;
  final bool disabled;
  final bool loading;
  final double borderRadius;
  final double height;
  final Color buttonColor;
  final Color textColor;
  final double width;
  final Widget? icon;
  final bool isOutlined;
  final double fontSize;
  final double horizontalPadding;
  final double verticalPadding;
  Gradient? gradient;
  BoxBorder? border;

  CustomButton(
      {super.key,
      this.label,
      required this.onClick,
      this.border,
      this.icon,
      this.disabled = false,
      this.loading = false,
      this.width = double.infinity,
      this.borderRadius = 10,
      this.height = 50,
      this.buttonColor = PTColor.primary,
      this.textColor = PTColor.white,
      this.gradient,
      this.fontSize = 14,
      this.horizontalPadding = 0,
      this.verticalPadding = 0,
      this.isOutlined = false});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: (disabled || loading) ? 0.6 : 1,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: gradient,
            color: isOutlined ? Colors.transparent : buttonColor,
            border:
                isOutlined ? Border.all(width: 2, color: buttonColor) : border),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: (disabled || loading)
                ? null
                : () {
                    onClick();
                  },
            child: Container(
                alignment: Alignment.center,
                height: height,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (null != icon)
                      Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: icon),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                            vertical: verticalPadding),
                        child: Text(
                          label ?? "Button",
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w700,
                              fontSize: fontSize.sp),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
