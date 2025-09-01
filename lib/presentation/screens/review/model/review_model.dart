
class ReviewModel {
  final bool? success;
  final String? message;
  final List<ReviewItem>? reviews;
  final double? avgRating;
  final double? totalReviews;

  ReviewModel({
    this.success,
    this.message,
    this.reviews,
    this.avgRating,
    this.totalReviews,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json){
    print("Rating 434444======================= ${json["avgRating"].toDouble()}");
    return ReviewModel(
      success: json["success"],
      message: json["message"],
      reviews: json["reviews"] == null ? [] : List<ReviewItem>.from(json["reviews"]!.map((x) => ReviewItem.fromJson(x))),
      avgRating: json["avgRating"]?.toDouble(),
      totalReviews: json["totalReviews"]?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
    "avgRating": avgRating,
    "totalReviews": totalReviews,
  };
}

class ReviewItem {
  final String? id;
  final String? comment;
  final num? rating;
  final String? businessId;
  final String? ownerId;
  final UserId? userId;
  final String? serviceId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? v;

  ReviewItem({
    this.id,
    this.comment,
    this.rating,
    this.businessId,
    this.ownerId,
    this.userId,
    this.serviceId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ReviewItem.fromJson(Map<String, dynamic> json) => ReviewItem(
    id: json["_id"],
    comment: json["comment"],
    rating: int.tryParse(json["rating"].toString()),
    businessId: json["businessId"],
    ownerId: json["ownerId"],
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    serviceId: json["serviceId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "comment": comment,
    "rating": rating,
    "businessId": businessId,
    "ownerId": ownerId,
    "userId": userId?.toJson(),
    "serviceId": serviceId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class UserId {
  final String? id;
  final String? name;
  final String? profilePic;

  UserId({
    this.id,
    this.name,
    this.profilePic,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    name: json["name"],
    profilePic: json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "profilePic": profilePic,
  };
}
