class BusinessBookingModel {
  final bool? success;
  final String? message;
  final List<BookingItem>? bookings;
  final int? totalPages;
  final int? totalBookings;
  final int? currentPage;
  final int? limit;

  BusinessBookingModel({
    this.success,
    this.message,
    this.bookings,
    this.totalPages,
    this.totalBookings,
    this.currentPage,
    this.limit,
  });

  factory BusinessBookingModel.fromJson(Map<String, dynamic> json) => BusinessBookingModel(
    success: json["success"],
    message: json["message"],
    bookings: json["bookings"] == null ? [] : List<BookingItem>.from(json["bookings"]!.map((x) => BookingItem.fromJson(x))),
    totalPages: json["totalPages"],
    totalBookings: json["totalBookings"],
    currentPage: json["currentPage"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "bookings": bookings == null ? [] : List<dynamic>.from(bookings!.map((x) => x.toJson())),
    "totalPages": totalPages,
    "totalBookings": totalBookings,
    "currentPage": currentPage,
    "limit": limit,
  };
}

class BookingItem {
  final String? id;
  final ServiceIdItem? serviceId;
  final String? userId;
  final DateTime? bookingDate;
  final String? bookingTime;
  final String? checkInTime;
  final String? checkOutTime;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final String? bookingStatus;
  final String? notes;
  final String? selectedService;
  final String? serviceType;
  final String? businessId;
  final String? ownerId;
  final String? petId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? cancellationReason;

  BookingItem({
    this.id,
    this.serviceId,
    this.userId,
    this.bookingDate,
    this.bookingTime,
    this.checkInTime,
    this.checkOutTime,
    this.checkInDate,
    this.checkOutDate,
    this.bookingStatus,
    this.notes,
    this.selectedService,
    this.serviceType,
    this.businessId,
    this.ownerId,
    this.petId,
    this.createdAt,
    this.updatedAt,
    this.cancellationReason,
  });

  factory BookingItem.fromJson(Map<String, dynamic> json) => BookingItem(
    id: json["_id"],
    serviceId: json["serviceId"] == null ? null : ServiceIdItem.fromJson(json["serviceId"]),
    userId: json["userId"],
    bookingDate: json["bookingDate"] == null ? null : DateTime.parse(json["bookingDate"]),
    bookingTime: json["bookingTime"],
    checkInTime: json["checkInTime"],
    checkOutTime: json["checkOutTime"],
    checkInDate: json["checkInDate"] == null ? null : DateTime.parse(json["checkInDate"]),
    checkOutDate: json["checkOutDate"] == null ? null : DateTime.parse(json["checkOutDate"]),
    bookingStatus: json["bookingStatus"],
    notes: json["notes"],
    selectedService: json["selectedService"],
    serviceType: json["serviceType"],
    businessId: json["businessId"],
    ownerId: json["ownerId"],
    petId: json["petId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    cancellationReason: json["cancellationReason"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "serviceId": serviceId?.toJson(),
    "userId": userId,
    "bookingDate": bookingDate?.toIso8601String(),
    "bookingTime": bookingTime,
    "checkInTime": checkInTime,
    "checkOutTime": checkOutTime,
    "checkInDate": checkInDate?.toIso8601String(),
    "checkOutDate": checkOutDate?.toIso8601String(),
    "bookingStatus": bookingStatus,
    "notes": notes,
    "selectedService": selectedService,
    "serviceType": serviceType,
    "businessId": businessId,
    "ownerId": ownerId,
    "petId": petId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "cancellationReason": cancellationReason,
  };
}

class ServiceIdItem {
  final String? id;
  final String? serviceType;
  final String? location;
  final String? shopLogo;
  final String? phone;
  final String? servicesImages;
  final String? businessId;
  final bool? isOpenNow;
  final String? serviceIdId;
  final String? websiteLink;

  ServiceIdItem({
    this.id,
    this.serviceType,
    this.location,
    this.shopLogo,
    this.phone,
    this.servicesImages,
    this.businessId,
    this.isOpenNow,
    this.serviceIdId,
    this.websiteLink,
  });

  factory ServiceIdItem.fromJson(Map<String, dynamic> json) => ServiceIdItem(
    id: json["_id"],
    serviceType: json["serviceType"],
    location: json["location"],
    shopLogo: json["shopLogo"],
    phone: json["phone"],
    servicesImages: json["servicesImages"],
    businessId: json["businessId"],
    isOpenNow: json["isOpenNow"],
    serviceIdId: json["id"],
    websiteLink: json["websiteLink"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "serviceType": serviceType,
    "location": location,
    "shopLogo": shopLogo,
    "phone": phone,
    "servicesImages": servicesImages,
    "businessId": businessId,
    "isOpenNow": isOpenNow,
    "id": serviceIdId,
    "websiteLink": websiteLink,
  };
}
