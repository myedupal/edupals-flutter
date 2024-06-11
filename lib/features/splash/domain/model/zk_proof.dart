class ZkProofRequest {
  String? jwt;
  String? extendedEphemeralPublicKey;
  String? maxEpoch;
  String? jwtRandomness;
  String? salt;
  String? keyClaimName;

  ZkProofRequest({
    this.jwt,
    this.extendedEphemeralPublicKey,
    this.maxEpoch,
    this.jwtRandomness,
    this.salt,
    this.keyClaimName,
  });

  factory ZkProofRequest.fromJson(Map<String, dynamic> json) => ZkProofRequest(
        jwt: json["jwt"],
        extendedEphemeralPublicKey: json["extendedEphemeralPublicKey"],
        maxEpoch: json["maxEpoch"],
        jwtRandomness: json["jwtRandomness"],
        salt: json["salt"],
        keyClaimName: json["keyClaimName"],
      );

  Map<String, dynamic> toJson() => {
        "jwt": jwt,
        "extendedEphemeralPublicKey": extendedEphemeralPublicKey,
        "maxEpoch": maxEpoch,
        "jwtRandomness": jwtRandomness,
        "salt": salt,
        "keyClaimName": keyClaimName,
      };
}
