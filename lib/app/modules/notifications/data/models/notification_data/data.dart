import 'properties.dart';

class Data {
  dynamic message;
  dynamic type;
  Properties? properties;

  Data({this.message, this.type, this.properties});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json['message'] as dynamic,
        type: json['type'] as dynamic,
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
