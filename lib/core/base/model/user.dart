class UserWrapper {
  UserWrapper({this.user, this.users, this.pages});

  String? pages;
  User? user;
  List<User>? users;

  factory UserWrapper.fromJson(Map<String, dynamic> json) => UserWrapper(
        pages: json["pages"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}

class User {
  String? id;
  String? name;
  bool? active;
  String? email;
  String? password;
  int? points;
  String? createdAt;
  String? updatedAt;
  dynamic stripeProfile;

  User({
    this.id,
    this.name,
    this.active,
    this.email,
    this.password,
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
        password: json["password"],
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
        "password": password,
        "points": points,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "stripe_profile": stripeProfile,
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null");
}
