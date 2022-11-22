import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize,
    FontWeight fontWeight,
    Color color) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontsConstants.familyFont,
    color: color,
    fontWeight: fontWeight,
  );
}


TextStyle getRegularStyle({
  double fontSize = FontSizes.s12,
  required Color color
}) {
  return _getTextStyle(fontSize, FontsWightsManager.regular , color);
}



TextStyle getMeduimStyle({
  double fontSize = FontSizes.s12,
  required Color color
}) {
  return _getTextStyle(fontSize, FontsWightsManager.medium , color);
}


TextStyle getLightStyle({
  double fontSize = FontSizes.s12,
  required Color color
}) {
  return _getTextStyle(fontSize, FontsWightsManager.light , color);
}


TextStyle getBoldStyle({
  double fontSize = FontSizes.s12,
  required Color color
}) {
  return _getTextStyle(fontSize, FontsWightsManager.bold , color);
}

TextStyle getSemiBoldStyle({
  double fontSize = FontSizes.s12,
  required Color color
}) {
  return _getTextStyle(fontSize, FontsWightsManager.semiBold , color);
}