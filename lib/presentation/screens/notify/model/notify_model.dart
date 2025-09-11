class NotifyModel {
  final bool? success;
  final List<Datum>? data;

  NotifyModel({
    this.success,
    this.data,
  });

  factory NotifyModel.fromJson(Map<String, dynamic> json) => NotifyModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  final String? title;
  final String? type;
  final String? message;
  final DateTime? time;

  Datum({
    this.title,
    this.type,
    this.message,
    this.time,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"],
    type: json["type"],
    message: json["message"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "type": type,
    "message": message,
    "time": time?.toIso8601String(),
  };
}
