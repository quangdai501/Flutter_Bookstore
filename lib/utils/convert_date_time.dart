// ignore: file_names
import 'package:intl/intl.dart';

// ignore: non_constant_identifier_names
String ConvertDateTime(var dateTime) {
  DateFormat formatter = DateFormat("yy-MM-dd HH:mm:ss");
  return formatter.format(dateTime);
}
