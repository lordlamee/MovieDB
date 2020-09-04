import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/models/video_model.dart';

getMovieUrl(String key) {
  return "https://img.youtube.com/vi/${key.replaceAll("_", "_") ?? ""}/0.jpg";
}

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

class RowHeading extends StatelessWidget {
  const RowHeading({Key key, this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
            ),
            Text(
              "See all",
              style: TextStyle(
                color:
                    Theme.of(context).textTheme.caption.color.withOpacity(0.8),
                fontSize: 15,
              ),
            ),
          ]),
    );
  }
}

rowHeading(String title, BuildContext context, bool bold, Function onPressed,
    List<Video> video) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              fontSize: 20,
            ),
          ),
          if (video.isNotEmpty)
            InkWell(
              onTap: onPressed,
              child: Text(
                "See all",
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .caption
                      .color
                      .withOpacity(0.8),
                  fontSize: 15,
                ),
              ),
            ),
        ]),
  );
}
