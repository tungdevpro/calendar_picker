// ignore_for_file: public_member_api_docs

import 'package:easy_calendar_picker/easy_calendar_picker.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../calendar_picker_inherited.dart';

class ListDayWidget extends StatefulWidget {
  final List<DateTime>? initDate;
  final bool visibleToday;
  final List<DayModel> days;
  final ValueChanged<List<DateTime>> onChanged;
  final CalendarPickerType pickType;

  const ListDayWidget({
    super.key,
    required this.visibleToday,
    required this.days,
    required this.onChanged,
    this.initDate,
    required this.pickType,
  });

  @override
  State<ListDayWidget> createState() => _ListDayWidgetState();
}

class _ListDayWidgetState extends State<ListDayWidget> {
  late List<DayModel> _days;
  List<DayModel> choices = [];

  @override
  void initState() {
    if (widget.initDate != null) {
      choices = widget.initDate!.map<DayModel>((e) => DayModel(date: e, enable: true)).toList();
    }
    _init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ListDayWidget oldWidget) {
    if (oldWidget.days != widget.days) _init();
    super.didUpdateWidget(oldWidget);
  }

  void _init() {
    _days = widget.days;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildListWeekdayShort(),
        const Gap(8),
        _buildListDay(),
      ],
    );
  }

  Widget _buildListWeekdayShort() {
    final weeks = CalendarPickerInherited.of(context).weekdays ?? [];
    if (weeks.isEmpty) return const SizedBox();
    return SizedBox(
      height: 40,
      child: GridView.count(
        crossAxisCount: 7,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: weeks.map<Widget>((e) => Center(child: Text(e))).toList(),
      ),
    );
  }

  Widget _buildListDay() {
    return GridView.builder(
      itemCount: _days.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 8),
      itemBuilder: (context, int index) {
        final e = _days[index];
        bool isToday = e.date.isToday && widget.visibleToday;
        bool isBetween = false;
        bool isFirst = choices.isNotEmpty ? choices.first.date.isAtSameDayAs(e.date) : false;
        bool isLast = false;
        if (choices.length > 1) {
          isBetween = e.date.isBetween(choices.first.date, choices.last.date) ?? false;
          isLast = choices.last.date.isAtSameDayAs(e.date);
        }
        bool isEnable = (isBetween || isFirst);
        return InkWell(
          onTap: () => _didTapElement(e),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final width = constraints.maxWidth;
              double? right = isLast ? null : 0;
              double? left = isLast ? 0 : null;
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  if (isEnable)
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: right,
                      left: left,
                      width: width / 2,
                      child: Container(
                        color: choices.length == 1 ? Colors.transparent : CalendarPickerInherited.of(context).calendarStyle.placeholderColor,
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      color: _getElementColor(date: e.date, isEnable: isEnable),
                      borderRadius: _getElementBorderRadius(date: e.date, isEnable: isEnable),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${e.text}',
                      style: TextStyle(
                          color:
                              isLast || isFirst ? Colors.white : (!e.enable ? CalendarPickerInherited.of(context).calendarStyle.textPlaceholderColor : null)),
                    ),
                  ),
                  if (isToday)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: CalendarPickerInherited.of(context).calendarStyle.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _didTapElement(DayModel e) {
    if (!e.enable) return;
    setState(() {
      if (widget.pickType == CalendarPickerType.single) {
        choices = [e];
      } else {
        if (choices.length >= 2) {
          choices = [e];
        } else {
          if (choices.length == 1) {
            if (e.date.isBefore(choices.first.date)) {
              return;
            }
            if (choices.last.date.isAtSameDayAs(e.date)) {
              choices = [];
              return;
            }
          }
          choices.add(e);
        }
      }
    });
    // if (choices.isNotEmpty) {
    widget.onChanged.call(choices.isEmpty ? <DateTime>[] : choices.map<DateTime>((e) => e.date).toList());
    // }
  }

  Color? _getElementColor({required DateTime date, required bool isEnable}) {
    Color? color;
    if (isEnable) {
      if (date.isAtSameDayAs(choices.first.date) || date.isAtSameDayAs(choices.last.date)) {
        return CalendarPickerInherited.of(context).calendarStyle.primaryColor;
      }
      color = CalendarPickerInherited.of(context).calendarStyle.placeholderColor;
    }
    return color;
  }

  BorderRadius? _getElementBorderRadius({required DateTime date, required bool isEnable}) {
    if (isEnable) {
      if (date.isAtSameDayAs(choices.first.date) || date.isAtSameDayAs(choices.last.date)) return BorderRadius.circular(50);
      return BorderRadius.zero;
    }
    return null;
  }
}
