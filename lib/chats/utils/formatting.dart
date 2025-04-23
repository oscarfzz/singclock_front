import 'package:intl/intl.dart';

DateTime parseDateTime(String value) {
  return DateFormat("yyyy-MM-ddTHH:mm:ssZ").parseUTC(value).toLocal();
}
