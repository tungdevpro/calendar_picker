import 'package:flutter/material.dart';

import 'common/styles/calendar_style.dart';

/// CalendarPickerInherited is a subclass of InheritedWidget,
///  allowing data to be passed from the parent widget to child widgets efficiently
///  and automatically when the data changes.
class CalendarPickerInherited extends InheritedWidget {
  // ignore: public_member_api_docs
  const CalendarPickerInherited({
    super.key,
    required super.child,
    required this.calendarStyle,
    this.weekdays,
  });

  /// Configure calendar colors
  final CalendarStyle calendarStyle;

  /// Displays the names of the days of the week
  final List<String>? weekdays;

  /// Static method to retrieve `CalendarPickerInherited` from the widget tree
  static CalendarPickerInherited? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CalendarPickerInherited>();
  }

  /// Static method to retrieve `CalendarPickerInherited` from the widget tree
  static CalendarPickerInherited of(BuildContext context) {
    final CalendarPickerInherited? result = maybeOf(context);
    assert(result != null, 'No CalendarPickerInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
