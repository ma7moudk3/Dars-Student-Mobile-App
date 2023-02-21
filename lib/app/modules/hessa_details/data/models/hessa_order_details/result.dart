import 'address.dart';
import 'level_topic.dart';
import 'order.dart';
import 'student.dart';

class Result {
  Order? order;
  List<LevelTopic>? levelTopics;
  List<dynamic>? candidateProvider;
  dynamic providerName;
  int? providerUserId;
  String? requesterName;
  int? requesterUserId;
  String? productName;
  dynamic providersNationalIdNumber;
  dynamic requesterUserName;
  dynamic paymentMethodName;
  dynamic currencyName;
  dynamic providersNationalIdNumber2;
  Address? address;
  List<Student>? students;
  List<dynamic>? skills;
  int? categoryId;
  String? categoryName;
  String? currentStatusStr;
  String? levelTopic;

  Result({
    this.order,
    this.levelTopics,
    this.candidateProvider,
    this.providerName,
    this.providerUserId,
    this.requesterName,
    this.requesterUserId,
    this.productName,
    this.providersNationalIdNumber,
    this.requesterUserName,
    this.paymentMethodName,
    this.currencyName,
    this.providersNationalIdNumber2,
    this.address,
    this.students,
    this.skills,
    this.categoryId,
    this.categoryName,
    this.currentStatusStr,
    this.levelTopic,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        order: json['order'] == null
            ? null
            : Order.fromJson(json['order'] as Map<String, dynamic>),
        levelTopics: (json['levelTopics'] as List<dynamic>?)
            ?.map((e) => LevelTopic.fromJson(e as Map<String, dynamic>))
            .toList(),
        candidateProvider: json['candidateProvider'] as List<dynamic>?,
        providerName: json['providerName'] as dynamic,
        providerUserId: json['providerUserId'] as int?,
        requesterName: json['requesterName'] as String?,
        requesterUserId: json['requesterUserId'] as int?,
        productName: json['productName'] as String?,
        providersNationalIdNumber: json['providersNationalIDNumber'] as dynamic,
        requesterUserName: json['requesterUser_Name'] as dynamic,
        paymentMethodName: json['paymentMethodName'] as dynamic,
        currencyName: json['currencyName'] as dynamic,
        providersNationalIdNumber2:
            json['providersNationalIDNumber2'] as dynamic,
        address: json['address'] == null
            ? null
            : Address.fromJson(json['address'] as Map<String, dynamic>),
        students: (json['students'] as List<dynamic>?)
            ?.map((e) => Student.fromJson(e as Map<String, dynamic>))
            .toList(),
        skills: json['skills'] as List<dynamic>?,
        categoryId: json['categoryId'] as int?,
        categoryName: json['categoryName'] as String?,
        currentStatusStr: json['currentStatusStr'] as String?,
        levelTopic: json['levelTopic'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'order': order?.toJson(),
        'levelTopics': levelTopics?.map((e) => e.toJson()).toList(),
        'candidateProvider': candidateProvider,
        'providerName': providerName,
        'providerUserId': providerUserId,
        'requesterName': requesterName,
        'requesterUserId': requesterUserId,
        'productName': productName,
        'providersNationalIDNumber': providersNationalIdNumber,
        'requesterUser_Name': requesterUserName,
        'paymentMethodName': paymentMethodName,
        'currencyName': currencyName,
        'providersNationalIDNumber2': providersNationalIdNumber2,
        'address': address?.toJson(),
        'students': students?.map((e) => e.toJson()).toList(),
        'skills': skills,
        'categoryId': categoryId,
        'categoryName': categoryName,
        'currentStatusStr': currentStatusStr,
        'levelTopic': levelTopic,
      };
}
