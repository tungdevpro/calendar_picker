import 'package:easy_calendar_picker/calendar_picker.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () {
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
          },
          child: const Text("Show calendar"),
        ),
      ),
    );
  }
}
