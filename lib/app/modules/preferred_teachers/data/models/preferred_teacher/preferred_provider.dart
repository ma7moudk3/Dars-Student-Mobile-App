class PreferredProvider {
  int? providerId;
  int? requesterId;
  int? id;

  PreferredProvider({this.providerId, this.requesterId, this.id});

  factory PreferredProvider.fromJson(Map<String, dynamic> json) {
    return PreferredProvider(
      providerId: json['providerId'] as int?,
      requesterId: json['requesterId'] as int?,
      id: json['id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'providerId': providerId,
        'requesterId': requesterId,
        'id': id,
      };
}
