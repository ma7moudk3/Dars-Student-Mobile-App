import 'message.dart';

class Properties {
  dynamic message;
  String? title;
  String? body;
  int? page;
  int? id;

  Properties({this.message, this.title, this.body, this.page, this.id});

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        message: json['Message'] == null
            ? null
            : json['Message'].runtimeType == String
                ? json['Message']
                : Message.fromJson(json['Message'] as Map<String, dynamic>),
        title: json['title'] as String?,
        body: json['body'] as String?,
        page: json['page'] as int?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'Message':
            message.runtimeType == Message ? message?.toJson() : message ?? "",
        'title': title,
        'body': body,
        'page': page,
        'id': id,
      };
}
