# Easy Calendar Picker

[![Pub Version](https://img.shields.io/pub/v/easy_calendar_picker.svg)](https://pub.dev/packages/easy_calendar_picker)

A simple and customizable calendar picker for Flutter.

## Features

- [x] Select single dates
- [x] Select date ranges
- [ ] Customize appearance (pending)
- [ ] Localization support (pending)

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  easy_calendar_picker: ^0.0.5
```

Then run flutter pub get.

## Usage
Import the package:

```dart
import 'package:easy_calendar_picker/easy_calendar_picker.dart';
```

### Single Date Picker
```dart
showBottomCalendarPicker(
    context,
    labelConfig: LabelConfiguration(name: 'App Calendar', textStyle: const TextStyle(fontSize: 18)),
    pickType: CalendarPickerType.single,
    onTapDate: (val) {},
);
```

### Date Range Picker
```dart
showBottomCalendarPicker(
    context,
    labelConfig: LabelConfiguration(name: 'App Calendar', textStyle: const TextStyle(fontSize: 18)),
    pickType: CalendarPickerType.range,
    onChanged: (fromDate, toDate) {},
);
```
## Maintainers
- [tungdo](https://github.com/tungdevpro)

## Contributions
Contributions are welcome! Please open an issue or submit a pull request.
