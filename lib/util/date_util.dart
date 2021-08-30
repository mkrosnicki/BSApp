import 'package:intl/intl.dart';

class DateUtil {

  static final DateFormat _dateFormat = new DateFormat.yMMMMd('pl');

  static String getFormatted(DateTime dateTime) {
    return _dateFormat.format(dateTime);
  }

  static DateTime parseFromStringToUtc(String date) {
    DateTime parsed = DateTime.parse(date);
    parsed = parsed.add(parsed.timeZoneOffset);
    parsed = parsed.toUtc();
    return parsed;
  }

  static String timeAgoString(DateTime dateTime) {
    final DateTime now = DateTime.now().toUtc();
    var diff = now.difference(dateTime.toUtc());
    // if (now.day - dateTime.day == 0) {
    //   return 'Dzisiaj, ${_timeFormat.format(dateTime)}';
    // }
    // if (now.day - dateTime.day == 1) {
    //   return 'Wczoraj, ${_timeFormat.format(dateTime)}';
    // }
    // if (diff.inDays >= 1) {
    //   return diff.inDays >= 30 ? _dateFormat.format(dateTime) : '${diff.inDays}d temu';
    // }
    if (diff.inDays >= 1) {
      return '${diff.inDays}d temu';
    }
    if (diff.inHours >= 1) {
      return '${diff.inHours}g temu';
    }
    if (diff.inMinutes >= 1) {
      return '${diff.inMinutes}m temu';
    }
    if (diff.inSeconds < 0) {
      return '0s temu';
    }
    return '${diff.inSeconds}s temu';
  }

}