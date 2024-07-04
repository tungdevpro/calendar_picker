import 'package:calendar_picker/src/calendar_picker_inherited.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class CustomButtonWidget extends StatelessWidget {
  CustomButtonWidget(
      {super.key,
      required this.text,
      this.onPress,
      this.enable = true,
      this.icon,
      this.prefixIcon,
      Color? bgrEnable,
      Color? bgrDisable,
      Color? textColorEnable,
      Color? textColorDisable,
      Color? borderColorEnable,
      this.textStyle,
      this.height = 48});

  final String text;
  final VoidCallback? onPress;
  final Widget? icon;
  final Widget? prefixIcon;
  final bool enable;
  late Color bgrEnable;
  late Color bgrDisable;
  late Color textColorEnable;
  late Color textColorDisable;
  final double? height;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final calendarStyle = CalendarPickerInherited.of(context).calendarStyle;
    bgrEnable = calendarStyle.getButtonEnableColor!;
    bgrDisable = calendarStyle.getButtonDisableColor!;
    textColorEnable = calendarStyle.getTextButtonEnableColor!;
    textColorDisable = calendarStyle.getTextButtonDisableColor!;
    return InkWell(
      onTap: enable ? onPress : null,
      child: Container(
          height: height ?? 48,
          decoration: BoxDecoration(
              color: enable ? bgrEnable : bgrDisable, borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prefixIcon != null) ...[prefixIcon!, const Gap(8)],
              Text(
                text,
                style: (textStyle ?? const TextStyle(fontSize: 14)).copyWith(color: enable ? textColorEnable : textColorDisable),
              ),
              if (icon != null) ...[const Gap(8), icon!],
            ],
          )),
    );
  }
}
