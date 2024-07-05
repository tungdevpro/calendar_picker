import 'package:flutter/material.dart';

import 'common/styles/calendar_style.dart';

class CalendarPickerInherited extends InheritedWidget {
  const CalendarPickerInherited({
    super.key,
    required super.child,
    required this.calendarStyle,
    this.weekdays,
  });

  final CalendarStyle calendarStyle;
  final List<String>? weekdays;

  static CalendarPickerInherited? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CalendarPickerInherited>();
  }

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
