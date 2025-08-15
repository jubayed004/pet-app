
class ServiceTypeModel {
  final bool? success;
  final String? message;
  final List<Service>? services;

  ServiceTypeModel({
    this.success,
    this.message,
    this.services,
  });

  factory ServiceTypeModel.fromJson(Map<String, dynamic> json) => ServiceTypeModel(
    success: json["success"],
    message: json["message"],
    services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
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
  final String? phone;
  final List<String>? providings;
  final String? servicesImages;
  final List<String>? bookings;
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
    phone: json["phone"],
    providings: json["providings"] == null ? [] : List<String>.from(json["providings"]!.map((x) => x)),
    servicesImages: json["servicesImages"],
    bookings: json["bookings"] == null ? [] : List<String>.from(json["bookings"]!.map((x) => x)),
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
