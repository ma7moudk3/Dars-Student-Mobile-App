class CandidateProvider {
  dynamic orderId;
  dynamic providerId;
  dynamic isSelectecd;
  dynamic rate;
  dynamic userId;
  String? userName;
  dynamic assignedProviderId;
  dynamic id;

  CandidateProvider({
    this.orderId,
    this.providerId,
    this.isSelectecd,
    this.rate,
    this.userId,
    this.userName,
    this.assignedProviderId,
    this.id,
  });

  factory CandidateProvider.fromJson(Map<String, dynamic> json) {
    return CandidateProvider(
      orderId: json['orderId'] as dynamic,
      providerId: json['providerId'] as dynamic,
      isSelectecd: json['isSelectecd'] as dynamic,
      rate: json['rate'] as dynamic,
      userId: json['userId'] as dynamic,
      userName: json['userName'] as String?,
      assignedProviderId: json['assignedProviderId'] as dynamic,
      id: json['id'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'providerId': providerId,
        'isSelectecd': isSelectecd,
        'rate': rate,
        'userId': userId,
        'userName': userName,
        'assignedProviderId': assignedProviderId,
        'id': id,
      };
}
