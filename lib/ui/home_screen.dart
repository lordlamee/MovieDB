import 'package:flutter/material.dart';
import 'package:movie_app/utilities/styles.dart' as Style;

class Home extends StatelessWidget {
  buildSearchField() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 40,
        right: 25,
        bottom: 30,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.4),
          contentPadding: EdgeInsets.zero,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
            size: 17,
          ),
          hintText: "Search",
          hintStyle: Style.defaultTextStyle.copyWith(
            fontSize: 12,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.appBlue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 40, right: 25, bottom: 30, top: 35),
            child: Text(
              "Hello, what do you \nwant to watch ?",
              style: Style.defaultTextStyle.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          buildSearchField(),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(25, 25, 0, 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Style.appDarkBlue,
              ),
              child: Column(children: <Widget>[
                RowHeading(
                  title: "RECOMMENDED FOR YOU",
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Avengers: Endgame",
                          style: Style.defaultTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        Row(
                          children: [
                            ImageIcon(
                              AssetImage("assets/star.png"),
                              color: Style.appYellow,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                RowHeading(
                  title: "TOP RATEd",
                ),
              ],),
            ),
          ),
        ],
      ),
    );
  }
}

class RowHeading extends StatelessWidget {
  const RowHeading({Key key, this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: Style.defaultTextStyle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Text(
              "See all",
              style: Style.defaultTextStyle.copyWith(
                color: Colors.white.withOpacity(0.5),
                fontSize: 13,
              ),
            ),
          ),
        ]);
  }
}
