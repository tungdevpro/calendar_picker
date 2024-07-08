import 'package:easy_calendar_picker/easy_calendar_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("$_dateTime"),
            const SizedBox(height: 30),
            FilledButton(
              onPressed: () {
                showBottomCalendarPicker(
                  context,
                  labelConfig: LabelConfiguration(name: 'App Calendar', textStyle: const TextStyle(fontSize: 18)),
                  pickType: CalendarPickerType.range,
                  calendarStyle: CalendarStyle(textPlaceholderColor: Colors.red, placeholderColor: Colors.pink),
                  onTapDate: (val) {
                    setState(() {
                      _dateTime = val;
                    });
                  },
                  onRangeChanged: (fromDate, toDate) {},
                );
              },
              child: const Text("Show calendar"),
            ),
          ],
        ),
      ),
    );
  }
}
