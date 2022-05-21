// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';

String ConvertNumberToCurrency(int num) {
  final oCcy = NumberFormat.currency(locale: "vi_VN");
  return oCcy.format(num);
}
