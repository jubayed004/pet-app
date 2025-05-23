

class ProfileModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final Data? data;

  ProfileModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final String? id;
  final AuthId? authId;
  final String? name;
  final String? email;
  final bool? isSubscribed;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Data({
    this.id,
    this.authId,
    this.name,
    this.email,
    this.isSubscribed,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    authId: json["authId"] == null ? null : AuthId.fromJson(json["authId"]),
    name: json["name"],
    email: json["email"],
    isSubscribed: json["isSubscribed"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "authId": authId?.toJson(),
    "name": name,
    "email": email,
    "isSubscribed": isSubscribed,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class AuthId {
  final String? id;
  final String? name;
  final String? email;
  final String? role;
  final bool? isBlocked;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  AuthId({
    this.id,
    this.name,
    this.email,
    this.role,
    this.isBlocked,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AuthId.fromJson(Map<String, dynamic> json) => AuthId(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
    isBlocked: json["isBlocked"],
    isActive: json["isActive"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "role": role,
    "isBlocked": isBlocked,
    "isActive": isActive,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
