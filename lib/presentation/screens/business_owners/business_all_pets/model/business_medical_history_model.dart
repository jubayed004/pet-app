class BusinessMedicalHistoryModel {
  final bool? success;
  final String? message;
  final int? page;
  final int? limit;
  final int? totalPages;
  final int? totalRecords;
  final List<PetMedicalHistoryByTreatmentStatus>? petMedicalHistory;

  BusinessMedicalHistoryModel({
    this.success,
    this.message,
    this.page,
    this.limit,
    this.totalPages,
    this.totalRecords,
    this.petMedicalHistory,
  });

  BusinessMedicalHistoryModel copyWith({
    bool? success,
    String? message,
    int? page,
    int? limit,
    int? totalPages,
    int? totalRecords,
    List<PetMedicalHistoryByTreatmentStatus>? petMedicalHistory,
  }) =>
      BusinessMedicalHistoryModel(
        success: success ?? this.success,
        message: message ?? this.message,
        page: page ?? this.page,
        limit: limit ?? this.limit,
        totalPages: totalPages ?? this.totalPages,
        totalRecords: totalRecords ?? this.totalRecords,
        petMedicalHistory: petMedicalHistory ?? this.petMedicalHistory,
      );

  factory BusinessMedicalHistoryModel.fromJson(Map<String, dynamic> json) => BusinessMedicalHistoryModel(
    success: json["success"],
    message: json["message"],
    page: json["page"],
    limit: json["limit"],
    totalPages: json["totalPages"],
    totalRecords: json["totalRecords"],
    petMedicalHistory: json["petMedicalHistory"] == null ? [] : List<PetMedicalHistoryByTreatmentStatus>.from(json["petMedicalHistory"]!.map((x) => PetMedicalHistoryByTreatmentStatus.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "page": page,
    "limit": limit,
    "totalPages": totalPages,
    "totalRecords": totalRecords,
    "petMedicalHistory": petMedicalHistory == null ? [] : List<dynamic>.from(petMedicalHistory!.map((x) => x.toJson())),
  };
}

class PetMedicalHistoryByTreatmentStatus {
  final String? treatmentType;
  final String? id;
  final String? petId;
  final DateTime? treatmentDate;
  final String? treatmentName;
  final String? doctorName;
  final String? treatmentDescription;
  final String? treatmentStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  PetMedicalHistoryByTreatmentStatus({
    this.treatmentType,
    this.id,
    this.petId,
    this.treatmentDate,
    this.treatmentName,
    this.doctorName,
    this.treatmentDescription,
    this.treatmentStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  PetMedicalHistoryByTreatmentStatus copyWith({
    String? treatmentType,
    String? id,
    String? petId,
    DateTime? treatmentDate,
    String? treatmentName,
    String? doctorName,
    String? treatmentDescription,
    String? treatmentStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      PetMedicalHistoryByTreatmentStatus(
        treatmentType: treatmentType ?? this.treatmentType,
        id: id ?? this.id,
        petId: petId ?? this.petId,
        treatmentDate: treatmentDate ?? this.treatmentDate,
        treatmentName: treatmentName ?? this.treatmentName,
        doctorName: doctorName ?? this.doctorName,
        treatmentDescription: treatmentDescription ?? this.treatmentDescription,
        treatmentStatus: treatmentStatus ?? this.treatmentStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory PetMedicalHistoryByTreatmentStatus.fromJson(Map<String, dynamic> json) => PetMedicalHistoryByTreatmentStatus(
    treatmentType: json["treatmentType"],
    id: json["_id"],
    petId: json["petId"],
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
    "treatmentType": treatmentType,
    "_id": id,
    "petId": petId,
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
