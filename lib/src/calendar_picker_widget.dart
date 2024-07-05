import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../calendar_picker.dart';
import 'calendar_picker_inherited.dart';
import 'component/calendar_picker_view_widget.dart';

typedef GetDateCalendarBuilder = void Function(DateTime fromDate, DateTime toDate);

class CalendarPickerWidget extends StatefulWidget {
  final List<DateTime>? initDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final GetDateCalendarBuilder onConfirm;
  final bool visibleToday;
  final String? label;
  final CalendarStyle? calendarStyle;
  final VoidCallback? onBack;
  final String cancelText;
  final String confirmText;
  final List<String>? weekdays;
  final Widget? actionWidget;

  const CalendarPickerWidget({
    super.key,
    this.initDate,
    this.minDate,
    this.maxDate,
    this.visibleToday = true,
    this.label,
    this.calendarStyle,
    this.onBack,
    this.cancelText = 'Cancel',
    this.confirmText = 'Confirm',
    this.weekdays,
    required this.onConfirm,
    this.actionWidget,
  });

  @override
  State<CalendarPickerWidget> createState() => _CalendarPickerWidgetState();
}

class _CalendarPickerWidgetState extends State<CalendarPickerWidget> {
  DateTime? _fromDateTime;
  DateTime? _toDateTime;
  DateTime? _minDate;
  DateTime? _maxDate;

  ValueNotifier<bool> confirmAbleNotifier = ValueNotifier(false);

  @override
  void initState() {
    _minDate = widget.minDate ?? DateTime(1930);
    _maxDate = widget.maxDate ?? DateTime(DateTime.now().year + 500);
    super.initState();
  }

  @override
  void dispose() {
    confirmAbleNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CalendarPickerInherited(
      calendarStyle: widget.calendarStyle ?? CalendarStyle.simple(),
      weekdays: widget.weekdays,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.label != null && widget.label != '') ...[
              Text(widget.label!),
              const Gap(24),
            ],
            CalendarPickerViewWidget(
              initDate: widget.initDate,
              minDate: _minDate,
              maxDate: _maxDate,
              visibleToday: widget.visibleToday,
              pickType: AppCalendarPickerType.range,
              onChanged: (List<DateTime> items) {
                confirmAbleNotifier.value = items.length == 2;
                if (items.length <= 1) return;
                _fromDateTime = items.first;
                _toDateTime = items.last;
                widget.onConfirm.call(_fromDateTime!, _toDateTime!);
              },
            ),
            if(widget.actionWidget != null) ...[
              const Gap(8),
              widget.actionWidget!,
            ],
          ],
        ),
      ),
    );
  }


}
