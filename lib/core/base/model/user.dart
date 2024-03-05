class User {
  String? id;
  String? name;
  bool? active;
  String? email;
  int? points;
  String? createdAt;
  String? updatedAt;
  dynamic stripeProfile;

  User({
    this.id,
    this.name,
    this.active,
    this.email,
    this.points,
    this.createdAt,
    this.updatedAt,
    this.stripeProfile,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        active: json["active"],
        email: json["email"],
        points: json["points"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        stripeProfile: json["stripe_profile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "active": active,
        "email": email,
        "points": points,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "stripe_profile": stripeProfile,
      };
}
