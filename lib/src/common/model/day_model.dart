// ignore_for_file: public_member_api_docs

class DayModel {
  final String? text;
  final DateTime date;
  final bool enable;

  DayModel({this.text, required this.date, required this.enable});

  @override
  String toString() {
    return '(text: $text, date: $date enable: $enable)';
  }
}
