import 'package:intl/intl.dart';

import '../constants/datetime_constant.dart';

extension DateTimeHelper on DateTime {
  String? toStringWithFormat({String format = DateTimeConstant.hourOnly}) {
    final formatter = DateFormat(
      format,
    );
    return formatter.format(this);
  }

  DateTime typeDate() {
    return DateTime(year, month, day);
  }
}
