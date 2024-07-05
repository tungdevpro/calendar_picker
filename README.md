# Calendar Picker

This package provides feature choice range date

## Feature

![img](https://raw.githubusercontent.com/tungdevpro/calendar_picker/main/example/screenshots/2.png)

## Usage

To display:
```dart
showModalBottomSheet(
context: context,
isScrollControlled: true,
builder: (_) {
    return CalendarPickerWidget(
        minDate: DateTime(2024, 3, 8),
        maxDate: DateTime(2025, 10, 1),
        onConfirm: (fromDate, toDate) {},
        actionWidget: const Row(
            children: [],
        ),
    );
});
```