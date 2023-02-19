class Properties {
  String? message;

  Properties({this.message});

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        message: json['Message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'Message': message,
      };
}
