import 'order.dart';

class Result {
  Order? order;
  String? productName;
  dynamic providersNationalIdNumber;
  dynamic requesterUserName;
  dynamic paymentMethodName;
  String? currencyName;
  dynamic providersNationalIdNumber2;
  String? addressName;
  dynamic categoryId;
  Result({
    this.order,
    this.productName,
    this.providersNationalIdNumber,
    this.requesterUserName,
    this.paymentMethodName,
    this.currencyName,
    this.providersNationalIdNumber2,
    this.addressName,
    this.categoryId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        order: json['order'] == null
            ? null
            : Order.fromJson(json['order'] as Map<String, dynamic>),
        productName: json['productName'] as String?,
        providersNationalIdNumber: json['providersNationalIDNumber'] as dynamic,
        requesterUserName: json['requesterUser_Name'] as dynamic,
        paymentMethodName: json['paymentMethodName'] as dynamic,
        currencyName: json['currencyName'] as String?,
        providersNationalIdNumber2:
            json['providersNationalIDNumber2'] as dynamic,
        addressName: json['addressName'] as String?,
        categoryId: json['categoryId'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'order': order?.toJson(),
        'productName': productName,
        'providersNationalIDNumber': providersNationalIdNumber,
        'requesterUser_Name': requesterUserName,
        'paymentMethodName': paymentMethodName,
        'currencyName': currencyName,
        'providersNationalIDNumber2': providersNationalIdNumber2,
        'addressName': addressName,
        'categoryId': categoryId,
      };
}
