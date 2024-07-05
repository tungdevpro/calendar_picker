import 'package:flutter/material.dart';

class DayModel {
  final String? text;
  final DateTime date;
  final bool enable;
  final Color? color;

  DayModel({this.text, required this.date, required this.enable, this.color});

  @override
  String toString() {
    return '(text: $text, date: $date enable: $enable)';
  }
}
