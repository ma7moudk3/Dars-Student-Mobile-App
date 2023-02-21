import 'order.dart';

class Result {
  Order? order;
  String? productName;
  int? productCategoryId;
  dynamic productCategoryName;
  dynamic providersNationalIdNumber;
  dynamic requesterUserName;
  dynamic paymentMethodName;
  String? currencyName;
  dynamic providersNationalIdNumber2;
  String? addressName;
  dynamic providerName;
  dynamic requesterName;
  dynamic levelTopic;

  Result({
    this.order,
    this.productName,
    this.productCategoryId,
    this.productCategoryName,
    this.providersNationalIdNumber,
    this.requesterUserName,
    this.paymentMethodName,
    this.currencyName,
    this.providersNationalIdNumber2,
    this.addressName,
    this.providerName,
    this.requesterName,
    this.levelTopic,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        order: json['order'] == null
            ? null
            : Order.fromJson(json['order'] as Map<String, dynamic>),
        productName: json['productName'] as String?,
        productCategoryId: json['productCategoryId'] as int?,
        productCategoryName: json['productCategoryName'] as dynamic,
        providersNationalIdNumber: json['providersNationalIDNumber'] as dynamic,
        requesterUserName: json['requesterUser_Name'] as dynamic,
        paymentMethodName: json['paymentMethodName'] as dynamic,
        currencyName: json['currencyName'] as String?,
        providersNationalIdNumber2:
            json['providersNationalIDNumber2'] as dynamic,
        addressName: json['addressName'] as String?,
        providerName: json['providerName'] as dynamic,
        requesterName: json['requesterName'] as dynamic,
        levelTopic: json['levelTopic'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'order': order?.toJson(),
        'productName': productName,
        'productCategoryId': productCategoryId,
        'productCategoryName': productCategoryName,
        'providersNationalIDNumber': providersNationalIdNumber,
        'requesterUser_Name': requesterUserName,
        'paymentMethodName': paymentMethodName,
        'currencyName': currencyName,
        'providersNationalIDNumber2': providersNationalIdNumber2,
        'addressName': addressName,
        'providerName': providerName,
        'requesterName': requesterName,
        'levelTopic': levelTopic,
      };
}
