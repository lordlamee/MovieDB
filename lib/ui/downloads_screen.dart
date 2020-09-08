import 'package:flutter/material.dart';
import 'package:movie_app/database/database.dart';
import 'package:movie_app/provider/downloads_provider.dart';
import 'package:provider/provider.dart';

class DownloadsScreen extends StatefulWidget {
  @override
  _DownloadsScreenState createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getDownloads(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<DownloadsProvider>(context).allDownloads != null &&
              Provider.of<DownloadsProvider>(context).allDownloads.isNotEmpty
          ? Consumer<DownloadsProvider>(
              builder: (context, provider, child) {
                return ListView.separated(
                  itemBuilder: (context, index) => Text(
                    provider.allDownloads[index].name,
                    style: TextStyle(),
                  ),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: provider.allDownloads.length,
                );
              },
            )
          : Center(
              child: Text(
                "No Downloads yet",
                style: TextStyle(),
              ),
            ),
    );
  }
}
