
class BusinessShopProfileModel {
  final bool? success;
  final String? message;
  final Business? business;

  BusinessShopProfileModel({
    this.success,
    this.message,
    this.business,
  });

  factory BusinessShopProfileModel.fromJson(Map<String, dynamic> json) => BusinessShopProfileModel(
    success: json["success"],
    message: json["message"],
    business: json["business"] == null ? null : Business.fromJson(json["business"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "business": business?.toJson(),
  };
}

class Business {
  final String? id;
  final String? ownerId;
  final String? businessName;
  final String? website;
  final String? address;
  final String? moreInfo;
  final String? shopLogo;
  final List<String>? shopPic;
  final List<String>? services;
  final List<dynamic>? reviews;
  final DateTime? createdAt;
  final int? v;
  final List<String>? servicesType;

  Business({
    this.id,
    this.ownerId,
    this.businessName,
    this.website,
    this.address,
    this.moreInfo,
    this.shopLogo,
    this.shopPic,
    this.services,
    this.reviews,
    this.createdAt,
    this.v,
    this.servicesType,
  });

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    id: json["_id"],
    ownerId: json["ownerId"],
    businessName: json["businessName"],
    website: json["website"],
    address: json["address"],
    moreInfo: json["moreInfo"],
    shopLogo: json["shopLogo"],
    shopPic: json["shopPic"] == null ? [] : List<String>.from(json["shopPic"]!.map((x) => x)),
    services: json["services"] == null ? [] : List<String>.from(json["services"]!.map((x) => x)),
    reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    v: json["__v"],
    servicesType: json["servicesType"] == null ? [] : List<String>.from(json["servicesType"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "ownerId": ownerId,
    "businessName": businessName,
    "website": website,
    "address": address,
    "moreInfo": moreInfo,
    "shopLogo": shopLogo,
    "shopPic": shopPic == null ? [] : List<dynamic>.from(shopPic!.map((x) => x)),
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
    "servicesType": servicesType == null ? [] : List<dynamic>.from(servicesType!.map((x) => x)),
  };
}
