import 'package:intl/intl.dart';

class DateUtil {

  static final DateFormat _dateFormat = new DateFormat.yMMMMd('pl');

  static String getFormatted(DateTime dateTime) {
    return _dateFormat.format(dateTime);
  }

  static DateTime parseFromStringToUtc(String date) {
    print('datedatedatedatedatedate');
    print(date);
    DateTime parsed = DateTime.parse(date);
    print(parsed);
    parsed = parsed.add(parsed.timeZoneOffset);
    print(parsed);
    parsed = parsed.toUtc();
    print(parsed);
    return parsed;
  }

  static String timeAgoString(DateTime dateTime) {
    final DateTime now = DateTime.now().toUtc();
    print(now);
    print(now.timeZoneOffset);
    print(dateTime);
    print(dateTime.timeZoneOffset);
    var diff = now.difference(dateTime.toUtc());
    print(diff);
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
    return '${diff.inSeconds}s temu';
  }

}