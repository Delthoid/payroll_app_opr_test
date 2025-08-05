import 'package:intl/intl.dart';

class Formatters {
  static String formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('MMM d, yyyy').format(dateTime);
  }

  static String formatDateLong(DateTime dateTime) {
    return DateFormat('MMMM d, yyyy').format(dateTime);
  }

  static String formatDateTime(DateTime dateTime) {
    return '${formatDate(dateTime)} - ${formatTime(dateTime)}';
  }
}