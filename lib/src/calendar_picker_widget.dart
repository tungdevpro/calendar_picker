import 'package:easy_calendar_picker/src/app_calendar_resource.dart';
import 'package:flutter/material.dart';

import '../calendar_picker.dart';
import 'calendar_picker_inherited.dart';
import 'common/component/calendar_picker_view_widget.dart';

typedef GetDateCalendarBuilder = void Function(DateTime? fromDate, DateTime? toDate);

class CalendarPickerWidget extends StatefulWidget {
  final List<DateTime>? initDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final GetDateCalendarBuilder? onRangeChanged;
  final bool visibleToday;
  final CalendarStyle? calendarStyle;
  final List<String>? weekdays;
  final LabelConfiguration? labelConfig;
  final CalendarPickerType? pickType;
  final ValueChanged<DateTime>? onTapDate;

  const CalendarPickerWidget({
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
  State<CalendarPickerWidget> createState() => _CalendarPickerWidgetState();
}

class _CalendarPickerWidgetState extends State<CalendarPickerWidget> {
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CalendarPickerInherited(
      calendarStyle: widget.calendarStyle ?? CalendarStyle.simple(),
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
