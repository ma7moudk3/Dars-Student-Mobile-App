class ProductDetails {
  dynamic totalHours;
  dynamic hourlyPrice;
  dynamic productPrice;
  bool? isPackage;
  String? nameL;
  String? nameF;
  String? name;
  dynamic detailsL;
  dynamic detailsF;
  dynamic details;
  bool? isActive;
  dynamic categoryId;
  dynamic currencyId;
  dynamic id;

  ProductDetails({
    this.totalHours,
    this.hourlyPrice,
    this.productPrice,
    this.isPackage,
    this.nameL,
    this.nameF,
    this.name,
    this.detailsL,
    this.detailsF,
    this.details,
    this.isActive,
    this.categoryId,
    this.currencyId,
    this.id,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      totalHours: json['totalHours'] as dynamic,
      hourlyPrice: json['hourlyPrice'] as dynamic,
      productPrice: json['productPrice'] as dynamic,
      isPackage: json['isPackage'] as bool?,
      nameL: json['nameL'] as String?,
      nameF: json['nameF'] as String?,
      name: json['name'] as String?,
      detailsL: json['detailsL'] as dynamic,
      detailsF: json['detailsF'] as dynamic,
      details: json['details'] as dynamic,
      isActive: json['isActive'] as bool?,
      categoryId: json['categoryId'] as dynamic,
      currencyId: json['currencyId'] as dynamic,
      id: json['id'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'totalHours': totalHours,
        'hourlyPrice': hourlyPrice,
        'productPrice': productPrice,
        'isPackage': isPackage,
        'nameL': nameL,
        'nameF': nameF,
        'name': name,
        'detailsL': detailsL,
        'detailsF': detailsF,
        'details': details,
        'isActive': isActive,
        'categoryId': categoryId,
        'currencyId': currencyId,
        'id': id,
      };
}
