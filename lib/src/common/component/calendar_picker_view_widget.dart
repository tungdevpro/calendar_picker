// ignore_for_file: public_member_api_docs

import 'package:dartx/dartx.dart';
import 'package:easy_calendar_picker/easy_calendar_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../calendar_picker_inherited.dart';
import 'list_day_widget.dart';

class CalendarPickerViewWidget extends StatefulWidget {
  final List<DateTime>? initDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final ValueChanged<List<DateTime>> onChanged;
  final bool visibleToday;
  final CalendarPickerType pickType;

  const CalendarPickerViewWidget({
    super.key,
    this.initDate,
    this.minDate,
    this.maxDate,
    required this.onChanged,
    required this.visibleToday,
    required this.pickType,
  });

  @override
  State<CalendarPickerViewWidget> createState() =>
      _CalendarPickerViewWidgetState();
}

class _CalendarPickerViewWidgetState extends State<CalendarPickerViewWidget> {
  late DateTime _today;
  late int _daysInMonth;
  List<DayModel> _days = [];
  DateTime? _minDate;

  bool previousEnable = true;
  bool nextEnable = true;
  bool isFromDateEnable = true;

  Color? get previousColorEnable => !previousEnable
      ? CalendarPickerInherited.of(context).calendarStyle.previousDisableColor
      : null;
  Color? get nextColorEnable => !nextEnable
      ? CalendarPickerInherited.of(context).calendarStyle.nextDisableColor
      : null;

  @override
  void initState() {
    _generateDateTime();
    super.initState();
  }

  void _generateDateTime({DateTime? inputDate, bool enablePreNext = true}) {
    _minDate = widget.minDate;
    _today = inputDate ?? DateTime.now();
    _daysInMonth = _today.daysInMonth;
    _setupDays(inputDate: inputDate);
    if (inputDate != null && enablePreNext) _setupPreNext(inputDate);
  }

  void _setupPreNext(DateTime inputDate) {
    previousEnable = _minDate != null
        ? !DateTime(inputDate.year, inputDate.month, inputDate.day)
            .isBefore(_minDate!)
        : true;
    nextEnable = widget.maxDate != null
        ? !DateTime(inputDate.year, inputDate.month + 1, inputDate.day)
            .isAfter(widget.maxDate!)
        : true;
  }

  void _setupDays({DateTime? inputDate}) {
    _days = [];
    for (var i = 0; i < _daysInMonth; i++) {
      final firstDay = _today.firstDayOfMonth.add(Duration(days: i));
      bool isAfter =
          widget.maxDate != null ? firstDay.isAfter(widget.maxDate!) : true;
      bool isBefore = _minDate != null ? firstDay.isBefore(_minDate!) : true;
      if (inputDate != null && !isFromDateEnable) {
        isBefore = firstDay.isBefore(inputDate);
      }
      _days.add(DayModel(
        text: i.plus(1).toString(),
        date: firstDay,
        enable: !isAfter && !isBefore,
      ));
    }
    previousDayOfCurrentMonth();
    nextDayOfCurrentMonth();
  }

  void previousDayOfCurrentMonth() {
    final firstWeekday = _days.first.date.weekday;
    final space = firstWeekday.minus(1);
    if (space == null || space == 0) return;
    final prevMonth = DateTime(_today.year, _today.month.minus(1)!);
    var items = <DayModel>[];
    var i = space;
    while (i > 0) {
      int day = prevMonth.daysInMonth - (i.minus(1)!);
      items.add(DayModel(
          text: day.toString(),
          date: DateTime(prevMonth.year, prevMonth.month, day),
          enable: false));
      i--;
    }
    if (items.isEmpty) return;
    _days.insertAll(0, items);
  }

  void nextDayOfCurrentMonth() {
    var items = <DayModel>[];
    final lastWeekday = _days.last.date.weekday;
    final space = DateTime.saturday - (lastWeekday.minus(1)!);
    if (space == 0) return;
    final nextMonth = DateTime(_today.year, _today.month.plus(1)!);
    var i = 1;
    while (i <= space) {
      final date = nextMonth.add(Duration(days: i));
      items.add(DayModel(text: i.toString(), date: date, enable: false));
      i++;
    }

    if (items.isEmpty) return;
    _days.addAll(items);
  }

  String _displayToday() => _today.toStringWithFormat('yyyy-MM');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(12),
        _buildTimeWidget(),
        const Gap(8),
        ListDayWidget(
          visibleToday: widget.visibleToday,
          days: _days,
          onChanged: widget.onChanged,
          initDate: widget.initDate,
          pickType: widget.pickType,
        ),
      ],
    );
  }

  Widget _buildTimeWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
            onTap: _didTapPrevious,
            child: Icon(Icons.keyboard_arrow_left,
                color: previousColorEnable, size: 22)),
        const Spacer(),
        Text(_displayToday(),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
        const Spacer(),
        InkWell(
            onTap: _didTapNext,
            child: Icon(Icons.keyboard_arrow_right,
                color: nextColorEnable, size: 22)),
      ],
    );
  }

  void _didTapPrevious() {
    if (!previousEnable) return;
    setState(() {
      _generateDateTime(inputDate: DateTime(_today.year, _today.month - 1));
    });
  }

  void _didTapNext() {
    if (!nextEnable) return;
    setState(() {
      _generateDateTime(inputDate: DateTime(_today.year, _today.month + 1));
    });
  }
}
