
class AppointmentBookingDetailsModel {
  final bool? success;
  final String? message;
  final Booking? booking;

  AppointmentBookingDetailsModel({
    this.success,
    this.message,
    this.booking,
  });

  factory AppointmentBookingDetailsModel.fromJson(Map<String, dynamic> json) => AppointmentBookingDetailsModel(
    success: json["success"],
    message: json["message"],
    booking: json["booking"] == null ? null : Booking.fromJson(json["booking"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "booking": booking?.toJson(),
  };
}

class Booking {
  final String? id;
  final ServiceId? serviceId;
  final String? userId;
  final DateTime? bookingDate;
  final String? bookingTime;
  final String? bookingStatus;
  final String? notes;
  final String? selectedService;
  final String? serviceType;
  final String? businessId;
  final String? ownerId;
  final String? petId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Booking({
    this.id,
    this.serviceId,
    this.userId,
    this.bookingDate,
    this.bookingTime,
    this.bookingStatus,
    this.notes,
    this.selectedService,
    this.serviceType,
    this.businessId,
    this.ownerId,
    this.petId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["_id"],
    serviceId: json["serviceId"] == null ? null : ServiceId.fromJson(json["serviceId"]),
    userId: json["userId"],
    bookingDate: json["bookingDate"] == null ? null : DateTime.parse(json["bookingDate"]),
    bookingTime: json["bookingTime"],
    bookingStatus: json["bookingStatus"],
    notes: json["notes"],
    selectedService: json["selectedService"],
    serviceType: json["serviceType"],
    businessId: json["businessId"],
    ownerId: json["ownerId"],
    petId: json["petId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "serviceId": serviceId?.toJson(),
    "userId": userId,
    "bookingDate": bookingDate?.toIso8601String(),
    "bookingTime": bookingTime,
    "bookingStatus": bookingStatus,
    "notes": notes,
    "selectedService": selectedService,
    "serviceType": serviceType,
    "businessId": businessId,
    "ownerId": ownerId,
    "petId": petId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class ServiceId {
  final String? id;
  final String? serviceType;
  final String? location;
  final String? websiteLink;
  final String? shopLogo;
  final String? phone;
  final String? servicesImages;
  final String? businessId;
  final bool? isOpenNow;
  final String? serviceIdId;

  ServiceId({
    this.id,
    this.serviceType,
    this.location,
    this.websiteLink,
    this.shopLogo,
    this.phone,
    this.servicesImages,
    this.businessId,
    this.isOpenNow,
    this.serviceIdId,
  });

  factory ServiceId.fromJson(Map<String, dynamic> json) => ServiceId(
    id: json["_id"],
    serviceType: json["serviceType"],
    location: json["location"],
    websiteLink: json["websiteLink"],
    shopLogo: json["shopLogo"],
    phone: json["phone"],
    servicesImages: json["servicesImages"],
    businessId: json["businessId"],
    isOpenNow: json["isOpenNow"],
    serviceIdId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "serviceType": serviceType,
    "location": location,
    "websiteLink": websiteLink,
    "shopLogo": shopLogo,
    "phone": phone,
    "servicesImages": servicesImages,
    "businessId": businessId,
    "isOpenNow": isOpenNow,
    "id": serviceIdId,
  };
}
