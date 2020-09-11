import 'package:intl/intl.dart';

class DateFormatHelper {
  static String simpelFormat(DateTime time) {
    final format = DateFormat.yMd();
    return format.format(time);
  }

  static String hourAndMinute(DateTime time, {String locale = 'id_ID'}) {
    final format = DateFormat.jm(locale);
    return format.format(time);
  }

  static String yearMonthDay(DateTime time, {String locale = 'id_ID'}){
    final formatDate = DateFormat.yMMMMd(locale);
    return formatDate.format(time);
  }
}
