import 'package:intl/intl.dart';

class DateUtilsHelper {
  static String formatDate(String date) {
    try {
      final parsed = DateTime.parse(date);
      return DateFormat.yMMMMd().format(parsed);
    } catch (_) {
      return date;
    }
  }
}
