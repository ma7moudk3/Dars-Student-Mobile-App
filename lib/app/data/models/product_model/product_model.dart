import 'dart:convert';

import 'plugin.dart';

class ProductModel {
  int? id;
  String? name;
  String? description;
  String? image;
  int? price;
  int? rate;
  int? categoryId;
  List<Plugin>? plugins;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.rate,
    this.categoryId,
    this.plugins,
  });

  factory ProductModel.fromMap(Map<String, dynamic> data) => ProductModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        description: data['description'] as String?,
        image: data['image'] as String?,
        price: int.parse(data['price'].toString()),
        rate: data['rate'] as int?,
        categoryId: data['category_id'] as int?,
        plugins: (data['plugins'] as List<dynamic>?)
            ?.map((e) => Plugin.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'image': image,
        'price': price,
        'rate': rate,
        'category_id': categoryId,
        'plugins': plugins?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProductModel].
  factory ProductModel.fromJson(String data) {
    return ProductModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProductModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
