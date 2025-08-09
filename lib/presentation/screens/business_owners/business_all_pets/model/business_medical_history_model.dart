
class BusinessMedicalHistoryModel {
  final bool? success;
  final String? message;
  final int? page;
  final int? limit;
  final int? totalPages;
  final int? totalRecords;
  final List<PetMedicalHistoryByTreatmentStatus>? petMedicalHistoryByTreatmentStatus;

  BusinessMedicalHistoryModel({
    this.success,
    this.message,
    this.page,
    this.limit,
    this.totalPages,
    this.totalRecords,
    this.petMedicalHistoryByTreatmentStatus,
  });

  factory BusinessMedicalHistoryModel.fromJson(Map<String, dynamic> json) => BusinessMedicalHistoryModel(
    success: json["success"],
    message: json["message"],
    page: json["page"],
    limit: json["limit"],
    totalPages: json["totalPages"],
    totalRecords: json["totalRecords"],
    petMedicalHistoryByTreatmentStatus: json["petMedicalHistoryByTreatmentStatus"] == null ? [] : List<PetMedicalHistoryByTreatmentStatus>.from(json["petMedicalHistoryByTreatmentStatus"]!.map((x) => PetMedicalHistoryByTreatmentStatus.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "page": page,
    "limit": limit,
    "totalPages": totalPages,
    "totalRecords": totalRecords,
    "petMedicalHistoryByTreatmentStatus": petMedicalHistoryByTreatmentStatus == null ? [] : List<dynamic>.from(petMedicalHistoryByTreatmentStatus!.map((x) => x.toJson())),
  };
}

class PetMedicalHistoryByTreatmentStatus {
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

  PetMedicalHistoryByTreatmentStatus({
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

  factory PetMedicalHistoryByTreatmentStatus.fromJson(Map<String, dynamic> json) => PetMedicalHistoryByTreatmentStatus(
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
