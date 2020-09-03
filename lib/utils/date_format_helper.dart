import 'package:intl/intl.dart';

class DateFormatHelper {
  static String simpelFormat(DateTime time) {
    final format = DateFormat.yMd();
    return format.format(time);
  }

  static String hourAndMinute(DateTime time) {
    final format = DateFormat.jm();
    return format.format(time);
  }
}
