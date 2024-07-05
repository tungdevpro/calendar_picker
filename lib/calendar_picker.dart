library easy_calendar_picker;

import 'package:flutter/material.dart';

import 'calendar_picker.dart';

export 'src/common/styles/label_style.dart';
export 'src/calendar_picker_widget.dart';
export 'src/common/styles/calendar_style.dart';
export 'src/common/enum.dart';
export 'src/common/extension.dart';
export 'src/common/model/day_model.dart';

Future<T?> showBottomCalendarPicker<T>(
  BuildContext context, {
  required GetDateCalendarBuilder onChanged,
  DateTime? minDate,
  DateTime? maxDate,
  List<DateTime>? intiDate,
  List<String>? weekdays,
  bool visibleToday = true,
  bool isScrollControlled = true,
  CalendarStyle? calendarStyle,
  LabelConfiguration? labelConfig,
}) async {
  return showModalBottomSheet<T?>(
    context: context,
    isScrollControlled: isScrollControlled,
    builder: (_) {
      return CalendarPickerWidget(
        onChanged: onChanged,
        minDate: minDate,
        maxDate: maxDate,
        initDate: intiDate,
        weekdays: weekdays ?? [],
        visibleToday: visibleToday,
        calendarStyle: calendarStyle,
        labelConfig: labelConfig,
      );
    },
  );
}
