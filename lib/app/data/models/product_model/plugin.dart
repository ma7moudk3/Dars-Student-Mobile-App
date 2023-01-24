import 'dart:convert';

class Plugin {
  int? id;
  String? title;
  int? price;

  Plugin({this.id, this.title, this.price});

  factory Plugin.fromMap(Map<String, dynamic> data) => Plugin(
        id: data['id'] as int?,
        title: data['title'] as String?,
        price: data['price'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'price': price,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Plugin].
  factory Plugin.fromJson(String data) {
    return Plugin.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Plugin] to a JSON string.
  String toJson() => json.encode(toMap());
}
