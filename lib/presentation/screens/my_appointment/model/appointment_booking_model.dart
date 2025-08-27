
class AppointmentBookingModel {
  final bool? success;
  final String? message;
  final List<Booking>? bookings;
  final int? totalPages;
  final int? totalBookings;
  final int? currentPage;
  final int? pageSize;
  final int? limit;

  AppointmentBookingModel({
    this.success,
    this.message,
    this.bookings,
    this.totalPages,
    this.totalBookings,
    this.currentPage,
    this.pageSize,
    this.limit,
  });

  factory AppointmentBookingModel.fromJson(Map<String, dynamic> json) => AppointmentBookingModel(
    success: json["success"],
    message: json["message"],
    bookings: json["bookings"] == null ? [] : List<Booking>.from(json["bookings"]!.map((x) => Booking.fromJson(x))),
    totalPages: json["totalPages"],
    totalBookings: json["totalBookings"],
    currentPage: json["currentPage"],
    pageSize: json["pageSize"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "bookings": bookings == null ? [] : List<dynamic>.from(bookings!.map((x) => x.toJson())),
    "totalPages": totalPages,
    "totalBookings": totalBookings,
    "currentPage": currentPage,
    "pageSize": pageSize,
    "limit": limit,
  };
}

class Booking {
  final String? id;
  final String? serviceId;
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
  final String? checkInTime;
  final String? checkOutTime;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;

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
    this.checkInTime,
    this.checkOutTime,
    this.checkInDate,
    this.checkOutDate,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["_id"],
    serviceId: json["serviceId"],
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
    checkInTime: json["checkInTime"],
    checkOutTime: json["checkOutTime"],
    checkInDate: json["checkInDate"] == null ? null : DateTime.parse(json["checkInDate"]),
    checkOutDate: json["checkOutDate"] == null ? null : DateTime.parse(json["checkOutDate"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "serviceId": serviceId,
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
    "checkInTime": checkInTime,
    "checkOutTime": checkOutTime,
    "checkInDate": checkInDate?.toIso8601String(),
    "checkOutDate": checkOutDate?.toIso8601String(),
  };
}
