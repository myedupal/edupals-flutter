class FileUrl {
  String? url;

  FileUrl({
    this.url,
  });

  factory FileUrl.fromJson(Map<String, dynamic> json) => FileUrl(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
