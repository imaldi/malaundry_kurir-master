import 'dart:developer';

import 'package:intl/intl.dart';

String formatMoney(val) {
  String money = "";
  if (val != null) {
    if (val is String) {
      money = NumberFormat.currency(
        decimalDigits: 0,
        symbol: "Rp. ",
        locale: "id",
      ).format(double.parse(val));
    } else {
      money = money = NumberFormat.currency(
        decimalDigits: 0,
        locale: "id",
        symbol: "Rp. ",
      ).format(val);
    }
  }
  return money;
}

String formatDate(DateTime dateNow, {bool withTimes = false}) {
  String date = "yyyy/dd/hh";
  if (dateNow != null) {
    date = DateFormat("yyyy-MM-dd").format(dateNow);
    if (withTimes) {
      date = DateFormat("dd MMMM yyyy hh:mm:ss").format(dateNow);
    }
  }
  return date;
}
