import 'package:easy_calendar_picker/src/resource.dart';
import 'package:flutter/material.dart';

import '../easy_calendar_picker.dart';
import 'calendar_picker_inherited.dart';
import 'common/component/calendar_picker_view_widget.dart';

/// Signature for the `builder` function which provide [fromDate] and [toDate]
typedef GetDateCalendarBuilder = void Function(DateTime? fromDate, DateTime? toDate);

///
class EasyCalendarPickerWidget extends StatefulWidget {
  /// Represents date data
  final List<DateTime>? initDate;

  /// Represents date data
  final DateTime? minDate;

  /// Represents date data
  final DateTime? maxDate;

  /// `onRangeChanged` is a callback function (`typedef GetDateCalendarBuilder`) that
  /// is called when the user changes the selected date range.
  final GetDateCalendarBuilder? onRangeChanged;

  /// Option to display current date
  final bool visibleToday;

  /// Configure calendar colors
  final CalendarStyle? calendarStyle;

  /// Displays the names of the days of the week
  final List<String>? weekdays;

  /// stores label configuration
  final LabelConfiguration? labelConfig;

  /// `pickType` is a enum. Support selected date single & range
  final CalendarPickerType? pickType;

  /// `onTapDate` is a callback function that
  /// is called when the user changes the selected date single
  final ValueChanged<DateTime>? onTapDate;

  // ignore: public_member_api_docs
  const EasyCalendarPickerWidget({
    super.key,
    this.initDate,
    this.minDate,
    this.maxDate,
    this.visibleToday = true,
    this.calendarStyle,
    this.weekdays,
    this.labelConfig,
    this.pickType,
    this.onTapDate,
    required this.onRangeChanged,
  });

  @override
  State<EasyCalendarPickerWidget> createState() => _CalendarPickerWidgetState();
}

class _CalendarPickerWidgetState extends State<EasyCalendarPickerWidget> {
  DateTime? _fromDateTime;
  DateTime? _toDateTime;
  DateTime? _minDate;
  DateTime? _maxDate;

  late final LabelConfiguration? _labelConfig = widget.labelConfig;

  @override
  void initState() {
    _minDate = widget.minDate ?? DateTime(1930);
    _maxDate = widget.maxDate ?? DateTime(DateTime.now().year + 500);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CalendarPickerInherited(
      calendarStyle: CalendarStyle.simple().copyWith(
        primaryColor: widget.calendarStyle?.primaryColor,
        placeholderColor: widget.calendarStyle?.placeholderColor,
        textPlaceholderColor: widget.calendarStyle?.textPlaceholderColor,
        nextColor: widget.calendarStyle?.nextColor,
        previousColor: widget.calendarStyle?.previousColor,
        nextDisableColor: widget.calendarStyle?.nextDisableColor,
        previousDisableColor: widget.calendarStyle?.previousDisableColor,
        fontSize: widget.calendarStyle?.fontSize,
      ),
      weekdays: (widget.weekdays?.isNotEmpty ?? false) ? widget.weekdays : Resource.weekdayShorts,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_labelConfig?.name != null && _labelConfig?.name != '')
              Text(
                _labelConfig!.name!,
                style: _labelConfig.textStyle,
              ),
            CalendarPickerViewWidget(
              initDate: widget.initDate,
              minDate: _minDate,
              maxDate: _maxDate,
              visibleToday: widget.visibleToday,
              pickType: widget.pickType ?? CalendarPickerType.range,
              onChanged: (List<DateTime> items) {
                if (widget.pickType == CalendarPickerType.single) {
                  if (items.isEmpty) return;
                  widget.onTapDate?.call(items.first);
                  return;
                }
                if (items.length <= 1) {
                  widget.onRangeChanged?.call(items.firstOrNull, null);
                  return;
                }
                _fromDateTime = items.firstOrNull;
                _toDateTime = items.lastOrNull;
                widget.onRangeChanged?.call(_fromDateTime!, _toDateTime!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
