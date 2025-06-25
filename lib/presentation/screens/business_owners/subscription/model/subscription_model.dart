class SubscriptionModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final Data? data;

  SubscriptionModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => SubscriptionModel(
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
  final List<SubscriptionPlan>? subscriptionPlans;

  Data({
    this.meta,
    this.subscriptionPlans,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    subscriptionPlans: json["subscriptionPlans"] == null ? [] : List<SubscriptionPlan>.from(json["subscriptionPlans"]!.map((x) => SubscriptionPlan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
    "subscriptionPlans": subscriptionPlans == null ? [] : List<dynamic>.from(subscriptionPlans!.map((x) => x.toJson())),
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

class SubscriptionPlan {
  final String? id;
  final String? subscriptionType;
  final List<String>? features;
  final double? price;
  final String? duration;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SubscriptionPlan({
    this.id,
    this.subscriptionType,
    this.features,
    this.price,
    this.duration,
    this.createdAt,
    this.updatedAt,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) => SubscriptionPlan(
    id: json["_id"],
    subscriptionType: json["subscriptionType"],
    features: json["features"] == null ? [] : List<String>.from(json["features"]!.map((x) => x)),
    price: json["price"]?.toDouble(),
    duration: json["duration"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "subscriptionType": subscriptionType,
    "features": features == null ? [] : List<dynamic>.from(features!.map((x) => x)),
    "price": price,
    "duration": duration,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
