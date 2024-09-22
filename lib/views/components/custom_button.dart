import 'package:e_commerce_app/controllers/auth_controller.dart';
import 'package:e_commerce_app/views/components/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/color-codes.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    this.onTap,
    this.text,
    this.bgColor,
    this.textFontSize,
    this.padding,
    this.textColor,
  });

  Function()? onTap;
  String? text;
  Color? bgColor;
  double? textFontSize;
  EdgeInsetsGeometry? padding;
  Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, value, child) {
      return InkWell(
        onTap: onTap ?? () {},
        child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width / 1.8,
            padding: padding ??
                const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
                color: bgColor ?? Colors.white,
                border: Border.all(color: ColorCodes.greyBr, width: 2),
                borderRadius: BorderRadius.circular(10)),
            child: value.isLoading! == false
                ? Center(
                    child: Text(
                      text ?? "",
                      style: FontManager.getTextStyle(context,
                          color: textColor ?? Colors.white,
                          fontSize: textFontSize ?? 16.0),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                color: Colors.white,
                                  ))),
      );
    });
  }
}
