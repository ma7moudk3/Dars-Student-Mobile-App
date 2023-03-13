import 'product_details.dart';

class Product {
  ProductDetails? productDetails;
  dynamic parentProductPackage;
  String? currencyNameL;

  Product({
    this.productDetails,
    this.parentProductPackage,
    this.currencyNameL,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productDetails: json['product'] == null
            ? null
            : ProductDetails.fromJson(
                json['product'] as Map<String, dynamic>),
        parentProductPackage: json['parentProductPackage'] as dynamic,
        currencyNameL: json['currencyNameL'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'productDetails': productDetails?.toJson(),
        'parentProductPackage': parentProductPackage,
        'currencyNameL': currencyNameL,
      };
}
