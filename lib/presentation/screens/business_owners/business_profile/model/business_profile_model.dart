class BusinessProfileModel {
  final bool? success;
  final String? message;
  final OwnerDetails? ownerDetails;

  BusinessProfileModel({
    this.success,
    this.message,
    this.ownerDetails,
  });

  BusinessProfileModel copyWith({
    bool? success,
    String? message,
    OwnerDetails? ownerDetails,
  }) =>
      BusinessProfileModel(
        success: success ?? this.success,
        message: message ?? this.message,
        ownerDetails: ownerDetails ?? this.ownerDetails,
      );

  factory BusinessProfileModel.fromJson(Map<String, dynamic> json) => BusinessProfileModel(
    success: json["success"],
    message: json["message"],
    ownerDetails: json["ownerDetails"] == null ? null : OwnerDetails.fromJson(json["ownerDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "ownerDetails": ownerDetails?.toJson(),
  };
}

class OwnerDetails {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final bool? isVerified;
  final bool? isBlocked;
  final String? role;
  final List<dynamic>? bookings;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? businesses;
  final String? profilePic;
  final Business? business;

  OwnerDetails({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.isVerified,
    this.isBlocked,
    this.role,
    this.bookings,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.businesses,
    this.profilePic,
    this.business,
  });

  OwnerDetails copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    bool? isVerified,
    bool? isBlocked,
    String? role,
    List<dynamic>? bookings,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    String? businesses,
    String? profilePic,
    Business? business,
  }) =>
      OwnerDetails(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        isVerified: isVerified ?? this.isVerified,
        isBlocked: isBlocked ?? this.isBlocked,
        role: role ?? this.role,
        bookings: bookings ?? this.bookings,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        businesses: businesses ?? this.businesses,
        profilePic: profilePic ?? this.profilePic,
        business: business ?? this.business,
      );

  factory OwnerDetails.fromJson(Map<String, dynamic> json) => OwnerDetails(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    isVerified: json["isVerified"],
    isBlocked: json["isBlocked"],
    role: json["role"],
    bookings: json["bookings"] == null ? [] : List<dynamic>.from(json["bookings"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    businesses: json["businesses"],
    profilePic: json["profilePic"],
    business: json["business"] == null ? null : Business.fromJson(json["business"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "isVerified": isVerified,
    "isBlocked": isBlocked,
    "role": role,
    "bookings": bookings == null ? [] : List<dynamic>.from(bookings!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "businesses": businesses,
    "profilePic": profilePic,
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
  final List<dynamic>? servicesType;
  final List<dynamic>? services;
  final List<dynamic>? reviews;
  final DateTime? createdAt;
  final int? v;

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
    this.v,
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
    List<dynamic>? servicesType,
    List<dynamic>? services,
    List<dynamic>? reviews,
    DateTime? createdAt,
    int? v,
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
        v: v ?? this.v,
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
    servicesType: json["servicesType"] == null ? [] : List<dynamic>.from(json["servicesType"]!.map((x) => x)),
    services: json["services"] == null ? [] : List<dynamic>.from(json["services"]!.map((x) => x)),
    reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    v: json["__v"],
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
    "__v": v,
  };
}
