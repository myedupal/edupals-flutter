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
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null" || value == "");
}

class User {
  String? id;
  String? name;
  String? phoneNumber;
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
  int? dailyStreak;
  int? maximumStreak;
  String? selectedCurriculumId;

  User({
    this.id,
    this.name,
    this.phoneNumber,
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
    this.dailyStreak,
    this.maximumStreak,
    this.selectedCurriculumId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
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
        dailyStreak: json["daily_streak"],
        maximumStreak: json["maximum_streak"],
        selectedCurriculumId: json["selected_curriculum_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone_number": phoneNumber,
        "active": active,
        "email": email,
        "points": points,
        "password": password,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "current_password": currentPassword,
        "password_confirmation": passwordConfirmation,
        "selected_curriculum_id": selectedCurriculumId,
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null" || value == "");

  Map<String, dynamic> toStore() => {
        "id": id,
        "name": name,
        "phone_number": phoneNumber,
        "active": active,
        "email": email,
        "points": points,
        "oauth2_provider": oauth2Provider,
        "oauth2_sub": oauth2Sub,
        "oauth2_profile_picture_url": oauth2ProfilePictureUrl,
        "daily_streak": dailyStreak,
        "maximum_streak": maximumStreak,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "stripe_profile": stripeProfile,
        "selected_curriculum_id": selectedCurriculumId,
      };
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
