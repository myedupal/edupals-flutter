class UserKey {
  String? randomness;
  String? nonce;
  String? publicKey;
  String? privateKey;
  int? maxEpoch;

  UserKey({
    this.randomness,
    this.nonce,
    this.publicKey,
    this.privateKey,
    this.maxEpoch,
  });

  factory UserKey.fromJson(Map<String, dynamic> json) => UserKey(
        randomness: json["randomness"],
        nonce: json["nonce"],
        publicKey: json["publicKey"],
        privateKey: json["privateKey"],
        maxEpoch: json["maxEpoch"],
      );

  Map<String, dynamic> toJson() => {
        "randomness": randomness,
        "nonce": nonce,
        "publicKey": publicKey,
        "privateKey": privateKey,
        "maxEpoch": maxEpoch,
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null" || value == "");
}
