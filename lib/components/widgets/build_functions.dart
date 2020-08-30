import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

formatDate(String date) {
  DateTime dateTime = DateTime.parse(date);
  return DateFormat.yMMMMd().format(dateTime).toString();
}

buildSearchIcon(BuildContext context, SearchDelegate delegate) {
  return InkWell(
    onTap: () {
      showSearch(context: context, delegate: delegate);
    },
    child: Icon(
      Icons.search,
    ),
  );
}
