
class BusinessProfileModel {
  final bool? success;
  final String? message;
  final OwnerDetails? ownerDetails;

  BusinessProfileModel({
    this.success,
    this.message,
    this.ownerDetails,
  });

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
    this.business,
  });

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
    this.services,
    this.reviews,
    this.createdAt,
    this.v,
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
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
  };
}
