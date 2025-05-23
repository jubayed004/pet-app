// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final Data? data;

  HomeModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
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
  final Meta? meta;
  final List<HomePost>? posts;

  Data({
    this.meta,
    this.posts,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    posts: json["posts"] == null ? [] : List<HomePost>.from(json["posts"]!.map((x) => HomePost.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
    "posts": posts == null ? [] : List<dynamic>.from(posts!.map((x) => x.toJson())),
  };
}

class Meta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  Meta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json["page"],
    limit: json["limit"],
    total: json["total"],
    totalPage: json["totalPage"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "totalPage": totalPage,
  };
}

class HomePost {
  final String? id;
  final String? postTitle;
  final String? sportType;
  final String? predictionType;
  final String? predictionDescription;
  final int? winRate;
  final String? targetUser;
  final String? oddsRange;
  final String? postImage;
  final PostedBy? postedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  HomePost({
    this.id,
    this.postTitle,
    this.sportType,
    this.predictionType,
    this.predictionDescription,
    this.winRate,
    this.targetUser,
    this.oddsRange,
    this.postImage,
    this.postedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory HomePost.fromJson(Map<String, dynamic> json) => HomePost(
    id: json["_id"],
    postTitle: json["postTitle"],
    sportType: json["sportType"],
    predictionType: json["predictionType"],
    predictionDescription: json["predictionDescription"],
    winRate: json["winRate"],
    targetUser: json["targetUser"],
    oddsRange: json["oddsRange"],
    postImage: json["post_image"],
    postedBy: json["postedBy"] == null ? null : PostedBy.fromJson(json["postedBy"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "postTitle": postTitle,
    "sportType": sportType,
    "predictionType": predictionType,
    "predictionDescription": predictionDescription,
    "winRate": winRate,
    "targetUser": targetUser,
    "oddsRange": oddsRange,
    "post_image": postImage,
    "postedBy": postedBy?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class PostedBy {
  final String? id;
  final String? authId;
  final String? name;
  final String? email;
  final String? profileImage;
  final String? phoneNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  PostedBy({
    this.id,
    this.authId,
    this.name,
    this.email,
    this.profileImage,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PostedBy.fromJson(Map<String, dynamic> json) => PostedBy(
    id: json["_id"],
    authId: json["authId"],
    name: json["name"],
    email: json["email"],
    profileImage: json["profile_image"],
    phoneNumber: json["phoneNumber"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "authId": authId,
    "name": name,
    "email": email,
    "profile_image": profileImage,
    "phoneNumber": phoneNumber,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
