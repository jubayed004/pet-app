class DashboardModel {
  final bool? success;
  final String? message;
  final String? viewType;
  final DateRange? dateRange;
  final List<Service>? services;
  final int? totalBookings;
  final List<dynamic>? bookings;
  final Stats? stats;

  DashboardModel({
    this.success,
    this.message,
    this.viewType,
    this.dateRange,
    this.services,
    this.totalBookings,
    this.bookings,
    this.stats,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    success: json["success"],
    message: json["message"],
    viewType: json["viewType"],
    dateRange: json["dateRange"] == null ? null : DateRange.fromJson(json["dateRange"]),
    services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
    totalBookings: json["totalBookings"],
    bookings: json["bookings"] == null ? [] : List<dynamic>.from(json["bookings"]!.map((x) => x)),
    stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "viewType": viewType,
    "dateRange": dateRange?.toJson(),
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
    "totalBookings": totalBookings,
    "bookings": bookings == null ? [] : List<dynamic>.from(bookings!.map((x) => x)),
    "stats": stats?.toJson(),
  };
}

class DateRange {
  final String? viewType;
  final int? month;
  final String? monthName;
  final int? year;
  final DateTime? start;
  final DateTime? end;

  DateRange({
    this.viewType,
    this.month,
    this.monthName,
    this.year,
    this.start,
    this.end,
  });

  factory DateRange.fromJson(Map<String, dynamic> json) => DateRange(
    viewType: json["viewType"],
    month: json["month"],
    monthName: json["monthName"],
    year: json["year"],
    start: json["start"] == null ? null : DateTime.parse(json["start"]),
    end: json["end"] == null ? null : DateTime.parse(json["end"]),
  );

  Map<String, dynamic> toJson() => {
    "viewType": viewType,
    "month": month,
    "monthName": monthName,
    "year": year,
    "start": "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
    "end": "${end!.year.toString().padLeft(4, '0')}-${end!.month.toString().padLeft(2, '0')}-${end!.day.toString().padLeft(2, '0')}",
  };
}

class Service {
  final String? id;

  Service({
    this.id,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}

class Stats {
  final int? total;
  final int? pending;
  final int? approved;
  final int? completed;
  final int? rejected;
  final int? cancelled;

  Stats({
    this.total,
    this.pending,
    this.approved,
    this.completed,
    this.rejected,
    this.cancelled,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    total: json["total"],
    pending: json["pending"],
    approved: json["approved"],
    completed: json["completed"],
    rejected: json["rejected"],
    cancelled: json["cancelled"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "pending": pending,
    "approved": approved,
    "completed": completed,
    "rejected": rejected,
    "cancelled": cancelled,
  };
}
