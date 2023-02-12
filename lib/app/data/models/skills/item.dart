class Item {
  int? id;
  String? displayName;

  Item({this.id, this.displayName});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'] as int?,
        displayName: json['displayName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'displayName': displayName,
      };
}
