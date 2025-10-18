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

  CategoryModel copyWith({
    bool? success,
    String? message,
    List<CategoryServiceItem>? services,
    int? currentPage,
    int? pageSize,
    int? total,
  }) =>
      CategoryModel(
        success: success ?? this.success,
        message: message ?? this.message,
        services: services ?? this.services,
        currentPage: currentPage ?? this.currentPage,
        pageSize: pageSize ?? this.pageSize,
        total: total ?? this.total,
      );

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
  final String? latitude;
  final String? longitude;
  final String? openingTime;
  final String? closingTime;
  final String? offDay;
  final String? shopLogo;
  final String? phone;
  final List<String>? providings;
  final String? servicesImages;
  final List<dynamic>? bookings;
  final String? businessId;
  final List<dynamic>? reviews;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? websiteLink;
  final bool? isOpenNow;
  final num? avgRating;

  CategoryServiceItem({
    this.id,
    this.serviceType,
    this.serviceName,
    this.location,
    this.latitude,
    this.longitude,
    this.openingTime,
    this.closingTime,
    this.offDay,
    this.shopLogo,
    this.phone,
    this.providings,
    this.servicesImages,
    this.bookings,
    this.businessId,
    this.reviews,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.websiteLink,
    this.isOpenNow,
    this.avgRating,
  });

  CategoryServiceItem copyWith({
    String? id,
    String? serviceType,
    String? serviceName,
    String? location,
    String? latitude,
    String? longitude,
    String? openingTime,
    String? closingTime,
    String? offDay,
    String? shopLogo,
    String? phone,
    List<String>? providings,
    String? servicesImages,
    List<dynamic>? bookings,
    String? businessId,
    List<dynamic>? reviews,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    String? websiteLink,
    bool? isOpenNow,
    num? avgRating,
  }) =>
      CategoryServiceItem(
        id: id ?? this.id,
        serviceType: serviceType ?? this.serviceType,
        serviceName: serviceName ?? this.serviceName,
        location: location ?? this.location,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        openingTime: openingTime ?? this.openingTime,
        closingTime: closingTime ?? this.closingTime,
        offDay: offDay ?? this.offDay,
        shopLogo: shopLogo ?? this.shopLogo,
        phone: phone ?? this.phone,
        providings: providings ?? this.providings,
        servicesImages: servicesImages ?? this.servicesImages,
        bookings: bookings ?? this.bookings,
        businessId: businessId ?? this.businessId,
        reviews: reviews ?? this.reviews,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        websiteLink: websiteLink ?? this.websiteLink,
        isOpenNow: isOpenNow ?? this.isOpenNow,
        avgRating: avgRating ?? this.avgRating,
      );

  factory CategoryServiceItem.fromJson(Map<String, dynamic> json) => CategoryServiceItem(
    id: json["_id"],
    serviceType: json["serviceType"],
    serviceName: json["serviceName"],
    location: json["location"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    openingTime: json["openingTime"],
    closingTime: json["closingTime"],
    offDay: json["offDay"],
    shopLogo: json["shopLogo"],
    phone: json["phone"],
    providings: json["providings"] == null ? [] : List<String>.from(json["providings"]!.map((x) => x)),
    servicesImages: json["servicesImages"],
    bookings: json["bookings"] == null ? [] : List<dynamic>.from(json["bookings"]!.map((x) => x)),
    businessId: json["businessId"],
    reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
    isActive: json["isActive"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    websiteLink: json["websiteLink"],
    isOpenNow: json["isOpenNow"],
    avgRating: json["avgRating"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "serviceType": serviceType,
    "serviceName": serviceName,
    "location": location,
    "latitude": latitude,
    "longitude": longitude,
    "openingTime": openingTime,
    "closingTime": closingTime,
    "offDay": offDay,
    "shopLogo": shopLogo,
    "phone": phone,
    "providings": providings == null ? [] : List<dynamic>.from(providings!.map((x) => x)),
    "servicesImages": servicesImages,
    "bookings": bookings == null ? [] : List<dynamic>.from(bookings!.map((x) => x)),
    "businessId": businessId,
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
    "isActive": isActive,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "websiteLink": websiteLink,
    "isOpenNow": isOpenNow,
    "avgRating": avgRating,
  };
}
