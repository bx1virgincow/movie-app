
import 'package:intl/intl.dart';

String formatDate(String date) {
  final DateTime dateTime = DateTime.parse(date);
  final DateFormat formatter = DateFormat('d/MM/yy');
  return formatter.format(dateTime);
}