class FileModel {
  int id;
  String url;
  String originName;
  String contentType;
  DateTime createdAt;
  FileModel({
    required this.id,
    required this.url,
    required this.contentType,
    required this.originName,
    required this.createdAt,
  });

  FileModel.fromJson(Map<String, dynamic> map)
    : this(
        id: map['id'],
        url: map['url'],
        contentType: map['contentType'],
        originName: map['originName'],
        createdAt: DateTime.parse(map['createdAt']),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'contentType': contentType,
      'originName': originName,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
