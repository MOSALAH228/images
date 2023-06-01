class PhotosModuel {
  PhotosModuel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  late int albumId;
  late int id;
  late String title;
  late String url;
  late String thumbnailUrl;

  factory PhotosModuel.fromJson(Map<String, dynamic> json) => PhotosModuel(
        albumId: json["albumId"] == null ? null : json["albumId"],
        id: json["id"] == null ? 1 : json["id"],
        title: json["title"] == null ? "" : json["title"],
        url: json["url"] == null ? "" : json["url"],
        thumbnailUrl: json["thumbnailUrl"] == null ? "" : json["thumbnailUrl"],
      );
}
