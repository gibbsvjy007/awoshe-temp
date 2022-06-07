import 'package:intl/intl.dart';

class DateUtils {

  static const DATE_FORMAT = 'dd-MM-yyyy';

  static String formatDateToString(DateTime date) {
    return DateFormat(DATE_FORMAT).format(date);
  }

  static DateTime formatStringToDate(String date) {
    DateFormat format = DateFormat(DATE_FORMAT);
    return format.parse(date);
  }
}