
class CategoryModel {
  final bool? success;
  final String? message;
  final List<CategoryServiceItem>? services;
  final int? currentPage;
  final int? pageSize;
  final int? total;

  CategoryModel({
    this.success,
    this.message,
    this.services,
    this.currentPage,
    this.pageSize,
    this.total,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    success: json["success"],
    message: json["message"],
    services: json["services"] == null ? [] : List<CategoryServiceItem>.from(json["services"]!.map((x) => CategoryServiceItem.fromJson(x))),
    currentPage: json["currentPage"],
    pageSize: json["pageSize"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
    "currentPage": currentPage,
    "pageSize": pageSize,
    "total": total,
  };
}

class CategoryServiceItem {
  final String? id;
  final String? serviceType;
  final String? serviceName;
  final String? location;
  final String? openingTime;
  final String? closingTime;
  final String? offDay;
  final String? websiteLink;
  final String? shopLogo;
  final String? phone;
  final List<String>? providings;
  final String? servicesImages;
  final List<String>? bookings;
  final String? businessId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final bool? isActive;
  final List<Review>? reviews;
  final bool? isOpenNow;

  CategoryServiceItem({
    this.id,
    this.serviceType,
    this.serviceName,
    this.location,
    this.openingTime,
    this.closingTime,
    this.offDay,
    this.websiteLink,
    this.shopLogo,
    this.phone,
    this.providings,
    this.servicesImages,
    this.bookings,
    this.businessId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isActive,
    this.reviews,
    this.isOpenNow,
  });

  factory CategoryServiceItem.fromJson(Map<String, dynamic> json) => CategoryServiceItem(
    id: json["_id"],
    serviceType: json["serviceType"],
    serviceName: json["serviceName"],
    location: json["location"],
    openingTime: json["openingTime"],
    closingTime: json["closingTime"],
    offDay: json["offDay"],
    websiteLink: json["websiteLink"],
    shopLogo: json["shopLogo"],
    phone: json["phone"],
    providings: json["providings"] == null ? [] : List<String>.from(json["providings"]!.map((x) => x)),
    servicesImages: json["servicesImages"],
    bookings: json["bookings"] == null ? [] : List<String>.from(json["bookings"]!.map((x) => x)),
    businessId: json["businessId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    isActive: json["isActive"],
    reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
    isOpenNow: json["isOpenNow"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "serviceType": serviceType,
    "serviceName": serviceName,
    "location": location,
    "openingTime": openingTime,
    "closingTime": closingTime,
    "offDay": offDay,
    "websiteLink": websiteLink,
    "shopLogo": shopLogo,
    "phone": phone,
    "providings": providings == null ? [] : List<dynamic>.from(providings!.map((x) => x)),
    "servicesImages": servicesImages,
    "bookings": bookings == null ? [] : List<dynamic>.from(bookings!.map((x) => x)),
    "businessId": businessId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "isActive": isActive,
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
    "isOpenNow": isOpenNow,
  };
}

class Review {
  final String? id;
  final String? comment;
  final double? rating;

  Review({
    this.id,
    this.comment,
    this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["_id"],
    comment: json["comment"],
    rating: json["rating"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "comment": comment,
    "rating": rating,
  };
}
