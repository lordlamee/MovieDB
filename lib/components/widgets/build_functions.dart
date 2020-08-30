import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

formatDate(String date) {
  if (date != null && date != "") {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat.yMMMMd().format(dateTime).toString();
  } else {
    return "date";
  }
}

formatDateToYear(String date) {
  if (date != null && date != "") {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat.y().format(dateTime).toString();
  } else {
    return "date";
  }
}

buildSearchIcon(BuildContext context, SearchDelegate delegate) {
  return IconButton(
    onPressed: () {
      showSearch(context: context, delegate: delegate);
    },
    icon: Icon(
      Icons.search,
    ),
  );
}
