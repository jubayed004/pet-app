

class LoginModel {
  final bool? success;
  final String? message;
  final String? accessToken;
  final String? refreshToken;
  final User? user;

  LoginModel({
    this.success,
    this.message,
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    message: json["message"],
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "user": user?.toJson(),
  };
}

class User {
  final String? id;
  final String? name;
  final String? email;
  final String? role;

  User({
    this.id,
    this.name,
    this.email,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "role": role,
  };
}
