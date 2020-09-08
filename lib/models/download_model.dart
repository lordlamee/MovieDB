import 'package:movie_app/database/database.dart';

class Download {
  int id;
  String name;
  String path;
  Download({this.name, this.path, this.id});
  Download.fromMap(Map<String, dynamic> map) {
    this.name = map[DatabaseProvider.COLUMN_NAME];
    this.id = map[DatabaseProvider.COLUMN_ID];
    this.path = map[DatabaseProvider.COLUMN_PATH];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      DatabaseProvider.COLUMN_NAME: name,
      DatabaseProvider.COLUMN_PATH: path,
    };
    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }
    return map;
  }
}
