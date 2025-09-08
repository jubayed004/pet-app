
class PetHealthModel {
  final bool? success;
  final String? message;
  final int? totalRecords;
  final int? currentPage;
  final int? totalPages;
  final List<HealthHistoryItem>? data;

  PetHealthModel({
    this.success,
    this.message,
    this.totalRecords,
    this.currentPage,
    this.totalPages,
    this.data,
  });

  factory PetHealthModel.fromJson(Map<String, dynamic> json) => PetHealthModel(
    success: json["success"],
    message: json["message"],
    totalRecords: json["totalRecords"],
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    data: json["data"] == null ? [] : List<HealthHistoryItem>.from(json["data"]!.map((x) => HealthHistoryItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "totalRecords": totalRecords,
    "currentPage": currentPage,
    "totalPages": totalPages,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class HealthHistoryItem {
  final String? id;
  final String? petId;
  final String? treatmentType;
  final DateTime? treatmentDate;
  final String? treatmentName;
  final String? doctorName;
  final String? treatmentDescription;
  final String? treatmentStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  HealthHistoryItem({
    this.id,
    this.petId,
    this.treatmentType,
    this.treatmentDate,
    this.treatmentName,
    this.doctorName,
    this.treatmentDescription,
    this.treatmentStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory HealthHistoryItem.fromJson(Map<String, dynamic> json) => HealthHistoryItem(
    id: json["_id"],
    petId: json["petId"],
    treatmentType: json["treatmentType"],
    treatmentDate: json["treatmentDate"] == null ? null : DateTime.parse(json["treatmentDate"]),
    treatmentName: json["treatmentName"],
    doctorName: json["doctorName"],
    treatmentDescription: json["treatmentDescription"],
    treatmentStatus: json["treatmentStatus"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "petId": petId,
    "treatmentType": treatmentType,
    "treatmentDate": treatmentDate?.toIso8601String(),
    "treatmentName": treatmentName,
    "doctorName": doctorName,
    "treatmentDescription": treatmentDescription,
    "treatmentStatus": treatmentStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
