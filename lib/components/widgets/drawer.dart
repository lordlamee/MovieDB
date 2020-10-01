import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/provider/theme_provide.dart';
import 'package:movie_app/ui/downloads_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          children: [
            Spacer(),
            Row(
              children: [
                Flexible(
                  child: Text(
                    "Movie Buddy",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Image(
                  image: AssetImage("assets/movieapplogo.png"),
                  height: 48,
                  width: 48,
                  fit: BoxFit.fill,
                ),
              ],
            ),
            Spacer(),
            RowButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => DownloadsScreen(),
                    ));
              },
              label: "Downloads",
              icon: Icon(
                Icons.save_alt,
                size: 24,
              ),
            ),
            Divider(),
            RowButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .switchTheme();
              },
              label: "Switch Theme",
              icon: Icon(
                Icons.brightness_3,
                size: 24,
              ),
            ),
            Divider(),
            RowButton(
              onPressed: () {
                showDialog(
                    context: context,
                    child: Dialog(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Text(
                            "Movie Buddy is database collection of movies...you can search ,watch and download trailers of your favorite movies"),
                      ),
                    ));
              },
              label: "About",
              icon: Icon(
                Icons.info,
                size: 24,
              ),
            ),
            Divider(),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class RowButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final Icon icon;

  const RowButton({Key key, this.onPressed, this.label, this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 24,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
