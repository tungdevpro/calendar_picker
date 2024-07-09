// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// `LabelConfiguration` is a class config, provide name, textStyle, fontSize, fontFamily & textAlign
class LabelConfiguration {
  final String? name;
  final TextStyle? textStyle;
  final double? fontSize;
  final String? fontFamily;
  final TextAlign? textAlign;

  LabelConfiguration(
      {this.name,
      this.textStyle,
      this.fontSize,
      this.fontFamily,
      this.textAlign});
}
