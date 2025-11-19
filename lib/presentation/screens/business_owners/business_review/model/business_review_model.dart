class BusinessReviewModel {
  final bool? success;
  final String? message;
  final Filters? filters;
  final Pagination? pagination;
  final num? avgRating;
  final List<ReviewItem>? reviews;

  BusinessReviewModel({
    this.success,
    this.message,
    this.filters,
    this.pagination,
    this.avgRating,
    this.reviews,
  });

  factory BusinessReviewModel.fromJson(Map<String, dynamic> json) => BusinessReviewModel(
    success: json["success"],
    message: json["message"],
    filters: json["filters"] == null ? null : Filters.fromJson(json["filters"]),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    avgRating: json["avgRating"],
    reviews: json["reviews"] == null ? [] : List<ReviewItem>.from(json["reviews"]!.map((x) => ReviewItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "filters": filters?.toJson(),
    "pagination": pagination?.toJson(),
    "avgRating": avgRating,
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
  };
}

class Filters {
  Filters();

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Pagination {
  final int? total;
  final int? page;
  final int? limit;
  final int? totalPages;

  Pagination({
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    page: json["page"],
    limit: json["limit"],
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "limit": limit,
    "totalPages": totalPages,
  };
}

class ReviewItem {
  final String? id;
  final String? comment;
  final num? rating;
  final String? businessId;
  final String? ownerId;
  final UserId? userId;
  final ServiceId? serviceId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

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
    rating: json["rating"],
    businessId: json["businessId"],
    ownerId: json["ownerId"],
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    serviceId: json["serviceId"] == null ? null : ServiceId.fromJson(json["serviceId"]),
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
    "serviceId": serviceId?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class ServiceId {
  final String? id;
  final String? serviceType;
  final String? serviceName;
  final bool? isOpenNow;
  final String? serviceIdId;

  ServiceId({
    this.id,
    this.serviceType,
    this.serviceName,
    this.isOpenNow,
    this.serviceIdId,
  });

  factory ServiceId.fromJson(Map<String, dynamic> json) => ServiceId(
    id: json["_id"],
    serviceType: json["serviceType"],
    serviceName: json["serviceName"],
    isOpenNow: json["isOpenNow"],
    serviceIdId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "serviceType": serviceType,
    "serviceName": serviceName,
    "isOpenNow": isOpenNow,
    "id": serviceIdId,
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
