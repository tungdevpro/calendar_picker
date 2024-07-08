library easy_calendar_picker;

import 'package:flutter/material.dart';

import 'easy_calendar_picker.dart';

export 'src/common/styles/label_style.dart';
export 'src/easy_calendar_picker_widget.dart';
export 'src/common/styles/calendar_style.dart';
export 'src/common/enum.dart';
export 'src/common/extension.dart';
export 'src/common/model/day_model.dart';

Future<T?> showBottomCalendarPicker<T>(
  BuildContext context, {
  GetDateCalendarBuilder? onRangeChanged,
  ValueChanged<DateTime>? onTapDate,
  DateTime? minDate,
  DateTime? maxDate,
  List<DateTime>? intiDate,
  List<String>? weekdays,
  bool visibleToday = true,
  bool isScrollControlled = true,
  CalendarStyle? calendarStyle,
  LabelConfiguration? labelConfig,
  CalendarPickerType? pickType,
  Color? backgroundColor,
  bool useRootNavigator = false,
  bool enableDrag = true,
  double? elevation,
}) async {
  return showModalBottomSheet<T?>(
    context: context,
    isScrollControlled: isScrollControlled,
    backgroundColor: backgroundColor,
    useRootNavigator: useRootNavigator,
    elevation: elevation,
    enableDrag: enableDrag,
    builder: (_) {
      return EasyCalendarPickerWidget(
        onRangeChanged: onRangeChanged,
        onTapDate: onTapDate,
        minDate: minDate,
        maxDate: maxDate,
        initDate: intiDate,
        weekdays: weekdays ?? [],
        visibleToday: visibleToday,
        calendarStyle: calendarStyle,
        labelConfig: labelConfig,
        pickType: pickType,
      );
    },
  );
}
