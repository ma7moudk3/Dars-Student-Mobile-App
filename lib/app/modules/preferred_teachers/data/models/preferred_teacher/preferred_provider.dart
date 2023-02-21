class PreferredProvider {
  int? providerId;
  int? providerUserId;
  int? requesterId;
  int? id;

  PreferredProvider(
      {this.providerId, this.requesterId, this.id, this.providerUserId});

  factory PreferredProvider.fromJson(Map<String, dynamic> json) {
    return PreferredProvider(
      providerId: json['providerId'] as int?,
      providerUserId: json['providerUserId'] as int?,
      requesterId: json['requesterId'] as int?,
      id: json['id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'providerId': providerId,
        'providerUserId': providerUserId,
        'requesterId': requesterId,
        'id': id,
      };
}
