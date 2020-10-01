import 'package:flutter/material.dart';
import 'package:movie_app/database/database.dart';
import 'package:movie_app/provider/downloads_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:android_intent/android_intent.dart';
import 'package:open_file/open_file.dart';

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

  Future openFile(filePath) async {
    final result = await OpenFile.open(filePath);
    return "type :${result.type.toString()} message: ${result.message}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Downloads",
          style: TextStyle(),
        ),
      ),
      body: Provider.of<DownloadsProvider>(context).allDownloads != null &&
              Provider.of<DownloadsProvider>(context).allDownloads.isNotEmpty
          ? Consumer<DownloadsProvider>(
              builder: (context, provider, child) {
                return ListView.separated(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      onTap: () async {
                        File videoFile =
                            File(provider.allDownloads[index].path);
                        if (Platform.isAndroid) {
                          AndroidIntent androidIntent = AndroidIntent(
                            action: 'action_view',
                            data: videoFile.path,
                            type: "video/mp4",
                          );
                          await androidIntent.launch();
                        } else {
                          await openFile(videoFile.path);
                        }
                      },
                      title: Text(
                        provider.allDownloads[index].name,
                        style: TextStyle(),
                      ),
                      leading: CircleAvatar(
                          child: Text(
                        provider.allDownloads[index].id.toString(),
                        style: TextStyle(),
                      )),
                    ),
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
