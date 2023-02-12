class ContentManagement {
  String? titleL;
  String? titleF;
  String? title;
  int? contentType;
  String? bodyL;
  String? bodyF;
  String? body;
  int? id;

  ContentManagement({
    this.titleL,
    this.titleF,
    this.title,
    this.contentType,
    this.bodyL,
    this.bodyF,
    this.body,
    this.id,
  });

  factory ContentManagement.fromJson(Map<String, dynamic> json) {
    return ContentManagement(
      titleL: json['titleL'] as String?,
      titleF: json['titleF'] as String?,
      title: json['title'] as String?,
      contentType: json['contentType'] as int?,
      bodyL: json['bodyL'] as String?,
      bodyF: json['bodyF'] as String?,
      body: json['body'] as String?,
      id: json['id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'titleL': titleL,
        'titleF': titleF,
        'title': title,
        'contentType': contentType,
        'bodyL': bodyL,
        'bodyF': bodyF,
        'body': body,
        'id': id,
      };
}
