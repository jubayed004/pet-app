
class MapCategoryDetailsModel {
  final bool? success;
  final String? message;
  final List<Service>? services;
  final int? count;

  MapCategoryDetailsModel({
    this.success,
    this.message,
    this.services,
    this.count,
  });

  factory MapCategoryDetailsModel.fromJson(Map<String, dynamic> json) => MapCategoryDetailsModel(
    success: json["success"],
    message: json["message"],
    services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
    "count": count,
  };
}

class Service {
  final String? id;
  final String? serviceType;
  final String? serviceName;
  final String? location;
  final String? latitude;
  final String? longitude;
  final String? openingTime;
  final String? closingTime;
  final String? offDay;
  final String? websiteLink;
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
  final double? latNum;
  final double? lngNum;
  final double? distanceKm;
  final bool? isOpenNow;

  Service({
    this.id,
    this.serviceType,
    this.serviceName,
    this.location,
    this.latitude,
    this.longitude,
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
    this.reviews,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.latNum,
    this.lngNum,
    this.distanceKm,
    this.isOpenNow,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["_id"],
    serviceType: json["serviceType"],
    serviceName: json["serviceName"],
    location: json["location"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    openingTime: json["openingTime"],
    closingTime: json["closingTime"],
    offDay: json["offDay"],
    websiteLink: json["websiteLink"],
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
    latNum: json["latNum"]?.toDouble(),
    lngNum: json["lngNum"]?.toDouble(),
    distanceKm: json["distanceKm"]?.toDouble(),
    isOpenNow: json["isOpenNow"],
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
    "websiteLink": websiteLink,
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
    "latNum": latNum,
    "lngNum": lngNum,
    "distanceKm": distanceKm,
    "isOpenNow": isOpenNow,
  };
}
