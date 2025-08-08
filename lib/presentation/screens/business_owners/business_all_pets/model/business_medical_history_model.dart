
class BusinessMedicalHistoryModel {
  final bool? success;
  final String? message;
  final List<PetMedicalHistory>? petMedicalHistory;

  BusinessMedicalHistoryModel({
    this.success,
    this.message,
    this.petMedicalHistory,
  });

  factory BusinessMedicalHistoryModel.fromJson(Map<String, dynamic> json) => BusinessMedicalHistoryModel(
    success: json["success"],
    message: json["message"],
    petMedicalHistory: json["petMedicalHistory"] == null ? [] : List<PetMedicalHistory>.from(json["petMedicalHistory"]!.map((x) => PetMedicalHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "petMedicalHistory": petMedicalHistory == null ? [] : List<dynamic>.from(petMedicalHistory!.map((x) => x.toJson())),
  };
}

class PetMedicalHistory {
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

  PetMedicalHistory({
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

  factory PetMedicalHistory.fromJson(Map<String, dynamic> json) => PetMedicalHistory(
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
