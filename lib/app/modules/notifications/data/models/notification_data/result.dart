import 'item.dart';

class Result {
  int? unreadCount;
  int? totalCount;
  List<Item>? items;

  Result({this.unreadCount, this.totalCount, this.items});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        unreadCount: json['unreadCount'] as int?,
        totalCount: json['totalCount'] as int?,
        items: (json['items'] as List<dynamic>?)
            ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'unreadCount': unreadCount,
        'totalCount': totalCount,
        'items': items?.map((e) => e.toJson()).toList(),
      };
}
