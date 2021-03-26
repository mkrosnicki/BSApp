import 'package:intl/intl.dart';

class DateUtil {

  static final DateFormat _dateFormat = new DateFormat.yMMMMd('pl');

  static String timeAgoString(DateTime dateTime) {
    var diff = DateTime.now().difference(dateTime);
    if (diff.inDays >= 1) {
      return diff.inDays >= 30 ? _dateFormat.format(dateTime) : '${diff.inDays}d temu';
    }
    if (diff.inHours >= 1) {
      return '${diff.inHours}g temu';
    }
    if (diff.inMinutes >= 1) {
      return '${diff.inMinutes}m temu';
    }
    return '${diff.inSeconds}s temu';
  }

}