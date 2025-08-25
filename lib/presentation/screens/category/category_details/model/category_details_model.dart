
class CategoryDetailsModel {
  final bool? success;
  final String? message;
  final Service? service;

  CategoryDetailsModel({
    this.success,
    this.message,
    this.service,
  });

  factory CategoryDetailsModel.fromJson(Map<String, dynamic> json) => CategoryDetailsModel(
    success: json["success"],
    message: json["message"],
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "service": service?.toJson(),
  };
}

class Service {
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
  final List<dynamic>? bookings;
  final String? businessId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Service({
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
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
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
    bookings: json["bookings"] == null ? [] : List<dynamic>.from(json["bookings"]!.map((x) => x)),
    businessId: json["businessId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
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
  };
}
