import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get toFormatString => DateFormat('yyyy/MM/dd HH:mm:ss').format(this);
}
