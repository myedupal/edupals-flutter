class UserWrapper {
  UserWrapper({
    this.user,
    this.users,
    this.meta,
    this.pages,
    this.account,
  });

  String? pages;
  User? user;
  UserMeta? meta;
  List<User>? users;
  User? account;

  factory UserWrapper.fromJson(Map<String, dynamic> json) => UserWrapper(
        pages: json["pages"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
        meta: json["meta"] == null ? null : UserMeta.fromJson(json["meta"]),
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
  String? oauth2Provider;
  String? oauth2Sub;
  String? oauth2ProfilePictureUrl;
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
    this.oauth2Provider,
    this.oauth2Sub,
    this.oauth2ProfilePictureUrl,
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
        oauth2Provider: json["oauth2_provider"],
        oauth2Sub: json["oauth2_sub"],
        oauth2ProfilePictureUrl: json["oauth2_profile_picture_url"],
        points: json["points"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        stripeProfile: json["stripe_profile"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "active": active,
        "email": email,
        "points": points,
        "password": password,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "current_password": currentPassword,
        "password_confirmation": passwordConfirmation,
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null" || value == "");
}

class UserMeta {
  String? zkloginSalt;

  UserMeta({
    this.zkloginSalt,
  });

  factory UserMeta.fromJson(Map<String, dynamic> json) => UserMeta(
        zkloginSalt: json["zklogin_salt"],
      );

  Map<String, dynamic> toJson() => {
        "zklogin_salt": zkloginSalt,
      };
}
