
class BusinessServiceModel {
  final bool? success;
  final String? message;
  final List<Service>? services;
  final int? total;
  final int? currentPage;
  final int? pageSize;
  final int? startIndex;
  final int? endIndex;

  BusinessServiceModel({
    this.success,
    this.message,
    this.services,
    this.total,
    this.currentPage,
    this.pageSize,
    this.startIndex,
    this.endIndex,
  });

  factory BusinessServiceModel.fromJson(Map<String, dynamic> json) => BusinessServiceModel(
    success: json["success"],
    message: json["message"],
    services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
    total: json["total"],
    currentPage: json["currentPage"],
    pageSize: json["pageSize"],
    startIndex: json["startIndex"],
    endIndex: json["endIndex"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
    "total": total,
    "currentPage": currentPage,
    "pageSize": pageSize,
    "startIndex": startIndex,
    "endIndex": endIndex,
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
  final List<String>? providings;
  final List<String>? servicesImages;
  final List<dynamic>? bookings;
  final String? businessId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? shopLogo;
  final String? address;

  Service({
    this.id,
    this.serviceType,
    this.serviceName,
    this.location,
    this.openingTime,
    this.closingTime,
    this.offDay,
    this.websiteLink,
    this.providings,
    this.servicesImages,
    this.bookings,
    this.businessId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.shopLogo,
    this.address,
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
    providings: json["providings"] == null ? [] : List<String>.from(json["providings"]!.map((x) => x)),
    servicesImages: json["servicesImages"] == null ? [] : List<String>.from(json["servicesImages"]!.map((x) => x)),
    bookings: json["bookings"] == null ? [] : List<dynamic>.from(json["bookings"]!.map((x) => x)),
    businessId: json["businessId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    shopLogo: json["shopLogo"],
    address: json["address"],
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
    "providings": providings == null ? [] : List<dynamic>.from(providings!.map((x) => x)),
    "servicesImages": servicesImages == null ? [] : List<dynamic>.from(servicesImages!.map((x) => x)),
    "bookings": bookings == null ? [] : List<dynamic>.from(bookings!.map((x) => x)),
    "businessId": businessId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "shopLogo": shopLogo,
    "address": address,
  };
}
