class Download {
  int id;
  String name;
  String path;
  Download({this.name, this.path, this.id});
  Download.fromMap(Map<String, dynamic> map) {
    this.name = map["name"];
    this.id = map["id"];
    this.path = map["path"];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["name"] = name;
    map["id"] = id;
    map["path"] = path;
    return map;
  }
}
