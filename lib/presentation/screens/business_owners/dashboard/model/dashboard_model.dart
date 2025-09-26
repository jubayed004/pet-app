class DashboardModel {
  final bool? success;
  final List<Service>? services;
  final int? totalBookings;
  final List<Booking>? bookings;
  final Stats? stats;

  DashboardModel({
    this.success,
    this.services,
    this.totalBookings,
    this.bookings,
    this.stats,
  });

  DashboardModel copyWith({
    bool? success,
    List<Service>? services,
    int? totalBookings,
    List<Booking>? bookings,
    Stats? stats,
  }) =>
      DashboardModel(
        success: success ?? this.success,
        services: services ?? this.services,
        totalBookings: totalBookings ?? this.totalBookings,
        bookings: bookings ?? this.bookings,
        stats: stats ?? this.stats,
      );

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    success: json["success"],
    services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
    totalBookings: json["totalBookings"],
    bookings: json["bookings"] == null ? [] : List<Booking>.from(json["bookings"]!.map((x) => Booking.fromJson(x))),
    stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
    "totalBookings": totalBookings,
    "bookings": bookings == null ? [] : List<dynamic>.from(bookings!.map((x) => x.toJson())),
    "stats": stats?.toJson(),
  };
}

class Booking {
  final String? id;
  final ServiceId? serviceId;
  final UserId? userId;
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
  final PetId? petId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Booking({
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
    this.v,
  });

  Booking copyWith({
    String? id,
    ServiceId? serviceId,
    UserId? userId,
    DateTime? bookingDate,
    String? bookingTime,
    String? checkInTime,
    String? checkOutTime,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    String? bookingStatus,
    String? notes,
    String? selectedService,
    String? serviceType,
    String? businessId,
    String? ownerId,
    PetId? petId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      Booking(
        id: id ?? this.id,
        serviceId: serviceId ?? this.serviceId,
        userId: userId ?? this.userId,
        bookingDate: bookingDate ?? this.bookingDate,
        bookingTime: bookingTime ?? this.bookingTime,
        checkInTime: checkInTime ?? this.checkInTime,
        checkOutTime: checkOutTime ?? this.checkOutTime,
        checkInDate: checkInDate ?? this.checkInDate,
        checkOutDate: checkOutDate ?? this.checkOutDate,
        bookingStatus: bookingStatus ?? this.bookingStatus,
        notes: notes ?? this.notes,
        selectedService: selectedService ?? this.selectedService,
        serviceType: serviceType ?? this.serviceType,
        businessId: businessId ?? this.businessId,
        ownerId: ownerId ?? this.ownerId,
        petId: petId ?? this.petId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["_id"],
    serviceId: json["serviceId"] == null ? null : ServiceId.fromJson(json["serviceId"]),
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
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
    petId: json["petId"] == null ? null : PetId.fromJson(json["petId"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "serviceId": serviceId?.toJson(),
    "userId": userId?.toJson(),
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
    "petId": petId?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class PetId {
  final String? id;
  final String? name;

  PetId({
    this.id,
    this.name,
  });

  PetId copyWith({
    String? id,
    String? name,
  }) =>
      PetId(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory PetId.fromJson(Map<String, dynamic> json) => PetId(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}

class ServiceId {
  final String? id;
  final bool? isOpenNow;
  final String? serviceIdId;

  ServiceId({
    this.id,
    this.isOpenNow,
    this.serviceIdId,
  });

  ServiceId copyWith({
    String? id,
    bool? isOpenNow,
    String? serviceIdId,
  }) =>
      ServiceId(
        id: id ?? this.id,
        isOpenNow: isOpenNow ?? this.isOpenNow,
        serviceIdId: serviceIdId ?? this.serviceIdId,
      );

  factory ServiceId.fromJson(Map<String, dynamic> json) => ServiceId(
    id: json["_id"],
    isOpenNow: json["isOpenNow"],
    serviceIdId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isOpenNow": isOpenNow,
    "id": serviceIdId,
  };
}

class UserId {
  final String? id;
  final String? name;
  final String? email;

  UserId({
    this.id,
    this.name,
    this.email,
  });

  UserId copyWith({
    String? id,
    String? name,
    String? email,
  }) =>
      UserId(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
      );

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
  };
}

class Service {
  final String? id;

  Service({
    this.id,
  });

  Service copyWith({
    String? id,
  }) =>
      Service(
        id: id ?? this.id,
      );

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}

class Stats {
  final Monthly? weekly;
  final Monthly? monthly;

  Stats({
    this.weekly,
    this.monthly,
  });

  Stats copyWith({
    Monthly? weekly,
    Monthly? monthly,
  }) =>
      Stats(
        weekly: weekly ?? this.weekly,
        monthly: monthly ?? this.monthly,
      );

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    weekly: json["weekly"] == null ? null : Monthly.fromJson(json["weekly"]),
    monthly: json["monthly"] == null ? null : Monthly.fromJson(json["monthly"]),
  );

  Map<String, dynamic> toJson() => {
    "weekly": weekly?.toJson(),
    "monthly": monthly?.toJson(),
  };
}

class Monthly {
  final int? total;
  final int? completed;

  Monthly({
    this.total,
    this.completed,
  });

  Monthly copyWith({
    int? total,
    int? completed,
  }) =>
      Monthly(
        total: total ?? this.total,
        completed: completed ?? this.completed,
      );

  factory Monthly.fromJson(Map<String, dynamic> json) => Monthly(
    total: json["total"],
    completed: json["completed"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "completed": completed,
  };
}
