class DashboardModel {
  final bool? success;
  final String? period;
  final Range? range;
  final Counts? counts;

  DashboardModel({
    this.success,
    this.period,
    this.range,
    this.counts,
  });

  DashboardModel copyWith({
    bool? success,
    String? period,
    Range? range,
    Counts? counts,
  }) =>
      DashboardModel(
        success: success ?? this.success,
        period: period ?? this.period,
        range: range ?? this.range,
        counts: counts ?? this.counts,
      );

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    success: json["success"],
    period: json["period"],
    range: json["range"] == null ? null : Range.fromJson(json["range"]),
    counts: json["counts"] == null ? null : Counts.fromJson(json["counts"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "period": period,
    "range": range?.toJson(),
    "counts": counts?.toJson(),
  };
}

class Counts {
  final int? total;
  final int? pending;
  final int? approved;
  final int? completed;
  final int? rejected;
  final int? cancelled;

  Counts({
    this.total,
    this.pending,
    this.approved,
    this.completed,
    this.rejected,
    this.cancelled,
  });

  Counts copyWith({
    int? total,
    int? pending,
    int? approved,
    int? completed,
    int? rejected,
    int? cancelled,
  }) =>
      Counts(
        total: total ?? this.total,
        pending: pending ?? this.pending,
        approved: approved ?? this.approved,
        completed: completed ?? this.completed,
        rejected: rejected ?? this.rejected,
        cancelled: cancelled ?? this.cancelled,
      );

  factory Counts.fromJson(Map<String, dynamic> json) => Counts(
    total: json["total"],
    pending: json["PENDING"],
    approved: json["APPROVED"],
    completed: json["COMPLETED"],
    rejected: json["REJECTED"],
    cancelled: json["CANCELLED"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "PENDING": pending,
    "APPROVED": approved,
    "COMPLETED": completed,
    "REJECTED": rejected,
    "CANCELLED": cancelled,
  };
}

class Range {
  final DateTime? start;
  final DateTime? end;

  Range({
    this.start,
    this.end,
  });

  Range copyWith({
    DateTime? start,
    DateTime? end,
  }) =>
      Range(
        start: start ?? this.start,
        end: end ?? this.end,
      );

  factory Range.fromJson(Map<String, dynamic> json) => Range(
    start: json["start"] == null ? null : DateTime.parse(json["start"]),
    end: json["end"] == null ? null : DateTime.parse(json["end"]),
  );

  Map<String, dynamic> toJson() => {
    "start": start?.toIso8601String(),
    "end": end?.toIso8601String(),
  };
}
