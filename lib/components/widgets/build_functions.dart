import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utilities/styles.dart' as Style;

buildSearchIcon(BuildContext context, SearchDelegate delegate) {
  return InkWell(
    onTap: () {
      showSearch(context: context, delegate: delegate);
    },
    child: Icon(
      Icons.search,
      color: Style.defaultWhite,
    ),
  );
}
