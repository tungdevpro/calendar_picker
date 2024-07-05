import 'package:flutter/material.dart';

import '../color_constants.dart';
import '../text_size.dart';
import 'button_style_color.dart';

class CalendarStyle {
  final Color? primaryColor;
  final Color? placeholderColor;
  final Color? textFirstLastColor;
  final Color? textPlaceholderColor;
  final Color? previousColor;
  final Color? previousDisableColor;
  final Color? nextColor;
  final Color? nextDisableColor;
  final ButtonStyleColor? buttonStyleColor;
  final double? fontSize;

  CalendarStyle({
    this.primaryColor,
    this.placeholderColor,
    this.textFirstLastColor,
    this.textPlaceholderColor,
    this.previousColor,
    this.previousDisableColor,
    this.nextColor,
    this.nextDisableColor,
    this.buttonStyleColor,
    this.fontSize,
  });

  factory CalendarStyle.simple() {
    return CalendarStyle(
      primaryColor: ColorConstants.primary,
      placeholderColor: ColorConstants.placeholder,
      textFirstLastColor: Colors.white,
      textPlaceholderColor: ColorConstants.textPlaceholder,
      nextColor: Colors.black,
      previousColor: Colors.black,
      nextDisableColor: Colors.grey.shade300,
      previousDisableColor: Colors.grey.shade300,
      buttonStyleColor: ButtonStyleColor(
        backgroundDisable: ColorConstants.buttonDisable,
        backgroundEnable: ColorConstants.primary,
        textDisable: ColorConstants.textButtonDisable,
        textEnable: Colors.white,
      ),
      fontSize: TextSize.medium,
    );
  }

  Color? get getButtonEnableColor => buttonStyleColor?.backgroundEnable;
  Color? get getButtonDisableColor => buttonStyleColor?.backgroundDisable;
  Color? get getTextButtonEnableColor => buttonStyleColor?.textEnable;
  Color? get getTextButtonDisableColor => buttonStyleColor?.textDisable;
}
