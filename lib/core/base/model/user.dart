class UserWrapper {
  UserWrapper({this.user, this.users, this.pages, this.account});

  String? pages;
  User? user;
  List<User>? users;
  User? account;

  factory UserWrapper.fromJson(Map<String, dynamic> json) => UserWrapper(
        pages: json["pages"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "account": account?.toJson(),
      };
}

class User {
  String? id;
  String? name;
  bool? active;
  String? email;
  String? password;
  String? currentPassword;
  String? passwordConfirmation;
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
    this.currentPassword,
    this.passwordConfirmation,
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
        "name": name,
        "active": active,
        "email": email,
        "password": password,
        "current_password": currentPassword,
        "password_confirmation": passwordConfirmation,
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null");
}
