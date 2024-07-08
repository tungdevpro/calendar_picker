import 'package:flutter/material.dart';

import '../color_constants.dart';
import '../text_size.dart';

class CalendarStyle {
  final Color? primaryColor;
  final Color? placeholderColor;
  final Color? textPlaceholderColor;
  final Color? previousColor;
  final Color? previousDisableColor;
  final Color? nextColor;
  final Color? nextDisableColor;
  final double? fontSize;

  CalendarStyle({
    this.primaryColor,
    this.placeholderColor,
    this.textPlaceholderColor,
    this.previousColor,
    this.previousDisableColor,
    this.nextColor,
    this.nextDisableColor,
    this.fontSize,
  });

  factory CalendarStyle.simple() {
    return CalendarStyle(
      primaryColor: ColorConstants.primary,
      placeholderColor: ColorConstants.placeholder,
      textPlaceholderColor: ColorConstants.textPlaceholder,
      nextColor: Colors.black,
      previousColor: Colors.black,
      nextDisableColor: Colors.grey.shade300,
      previousDisableColor: Colors.grey.shade300,
      fontSize: TextSize.medium,
    );
  }

  CalendarStyle copyWith({
    Color? primaryColor,
    Color? placeholderColor,
    Color? textPlaceholderColor,
    Color? previousColor,
    Color? previousDisableColor,
    Color? nextColor,
    Color? nextDisableColor,
    double? fontSize,
  }) {
    return CalendarStyle(
      primaryColor: primaryColor ?? this.primaryColor,
      placeholderColor: placeholderColor ?? this.placeholderColor,
      textPlaceholderColor: textPlaceholderColor ?? this.textPlaceholderColor,
      nextColor: nextColor ?? this.nextColor,
      previousColor: previousColor ?? this.previousColor,
      nextDisableColor: nextDisableColor ?? this.nextDisableColor,
      previousDisableColor: previousDisableColor ?? this.previousDisableColor,
      fontSize: fontSize ?? this.fontSize,
    );
  }
}
