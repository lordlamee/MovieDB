class Video {
  String id;
  String name;
  String language;
  String site;
  String type;
  int size;
  String key;
  Video(
      {this.name,
      this.size,
      this.type,
      this.id,
      this.key,
      this.language,
      this.site});

  Video.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    language = "${json["iso_639_1"]}" + " ${json["iso_3166_1"]}";
    site = json["site"];
    type = json["type"];
    key = json["key"];
    size = json["size"];
  }
}
