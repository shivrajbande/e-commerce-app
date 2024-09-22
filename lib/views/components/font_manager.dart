import 'package:e_commerce_app/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontManager {
  static TextStyle getTextStyle(
    BuildContext context, {
    Color color = Colors.black,
    FontWeight lWeight = FontWeight.w400,
    lineHeight = 1.0,
    maxLines = 2,
    String fontName = AppConstants.fontNamePoppins,
    FontStyle lFontStyle = FontStyle.normal,
    softWrap = false,
    double fontSize = 12.0,
    decoration = TextDecoration.none,
    letterSpacing = 0.0,
    TextOverflow overflow = TextOverflow.visible,
  }) {
    return GoogleFonts.getFont("Poppins",
        textStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: lWeight,
            height: lineHeight,
            fontStyle: lFontStyle,
            color: color,
            letterSpacing: letterSpacing,
            decoration: decoration));
  }
}
