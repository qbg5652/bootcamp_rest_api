import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatString(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}분 전';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}시간 전';
    } else if (diff.inDays < 8) {
      return '${diff.inDays}일 전';
    } else {
      return DateFormat('M월 d일').format(dateTime);
    }
  }
}
