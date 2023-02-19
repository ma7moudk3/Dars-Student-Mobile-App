import 'properties.dart';

class Data {
  String? message;
  String? type;
  Properties? properties;

  Data({this.message, this.type, this.properties});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json['message'] as String?,
        type: json['type'] as String?,
        properties: json['properties'] == null
            ? null
            : Properties.fromJson(json['properties'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'type': type,
        'properties': properties?.toJson(),
      };
}
