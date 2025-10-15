class BusinessShopProfileModel {
  final bool? success;
  final String? message;
  final List<Business>? business;

  BusinessShopProfileModel({
    this.success,
    this.message,
    this.business,
  });

  BusinessShopProfileModel copyWith({
    bool? success,
    String? message,
    List<Business>? business,
  }) =>
      BusinessShopProfileModel(
        success: success ?? this.success,
        message: message ?? this.message,
        business: business ?? this.business,
      );

  factory BusinessShopProfileModel.fromJson(Map<String, dynamic> json) => BusinessShopProfileModel(
    success: json["success"],
    message: json["message"],
    business: json["business"] == null ? [] : List<Business>.from(json["business"]!.map((x) => Business.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "business": business == null ? [] : List<dynamic>.from(business!.map((x) => x.toJson())),
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
  final List<String>? servicesType;
  final List<String>? services;
  final List<String>? reviews;
  final DateTime? createdAt;

  Business({
    this.id,
    this.ownerId,
    this.businessName,
    this.website,
    this.address,
    this.moreInfo,
    this.shopLogo,
    this.shopPic,
    this.servicesType,
    this.services,
    this.reviews,
    this.createdAt,
  });

  Business copyWith({
    String? id,
    String? ownerId,
    String? businessName,
    String? website,
    String? address,
    String? moreInfo,
    String? shopLogo,
    List<String>? shopPic,
    List<String>? servicesType,
    List<String>? services,
    List<String>? reviews,
    DateTime? createdAt,
  }) =>
      Business(
        id: id ?? this.id,
        ownerId: ownerId ?? this.ownerId,
        businessName: businessName ?? this.businessName,
        website: website ?? this.website,
        address: address ?? this.address,
        moreInfo: moreInfo ?? this.moreInfo,
        shopLogo: shopLogo ?? this.shopLogo,
        shopPic: shopPic ?? this.shopPic,
        servicesType: servicesType ?? this.servicesType,
        services: services ?? this.services,
        reviews: reviews ?? this.reviews,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    id: json["_id"],
    ownerId: json["ownerId"],
    businessName: json["businessName"],
    website: json["website"],
    address: json["address"],
    moreInfo: json["moreInfo"],
    shopLogo: json["shopLogo"],
    shopPic: json["shopPic"] == null ? [] : List<String>.from(json["shopPic"]!.map((x) => x)),
    servicesType: json["servicesType"] == null ? [] : List<String>.from(json["servicesType"]!.map((x) => x)),
    services: json["services"] == null ? [] : List<String>.from(json["services"]!.map((x) => x)),
    reviews: json["reviews"] == null ? [] : List<String>.from(json["reviews"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
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
    "servicesType": servicesType == null ? [] : List<dynamic>.from(servicesType!.map((x) => x)),
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
  };
}
