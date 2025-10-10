class MyAllPetsDetailsModel {
  final bool? success;
  final String? message;
  final int? totalRecords;
  final int? currentPage;
  final int? totalPages;
  final List<PetMedicalHistory>? data;

  MyAllPetsDetailsModel({
    this.success,
    this.message,
    this.totalRecords,
    this.currentPage,
    this.totalPages,
    this.data,
  });

  MyAllPetsDetailsModel copyWith({
    bool? success,
    String? message,
    int? totalRecords,
    int? currentPage,
    int? totalPages,
    List<PetMedicalHistory>? data,
  }) =>
      MyAllPetsDetailsModel(
        success: success ?? this.success,
        message: message ?? this.message,
        totalRecords: totalRecords ?? this.totalRecords,
        currentPage: currentPage ?? this.currentPage,
        totalPages: totalPages ?? this.totalPages,
        data: data ?? this.data,
      );

  factory MyAllPetsDetailsModel.fromJson(Map<String, dynamic> json) => MyAllPetsDetailsModel(
    success: json["success"],
    message: json["message"],
    totalRecords: json["totalRecords"],
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    data: json["data"] == null ? [] : List<PetMedicalHistory>.from(json["data"]!.map((x) => PetMedicalHistory.fromJson(x))),
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

  PetMedicalHistory copyWith({
    String? id,
    String? petId,
    String? treatmentType,
    DateTime? treatmentDate,
    String? treatmentName,
    String? doctorName,
    String? treatmentDescription,
    String? treatmentStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      PetMedicalHistory(
        id: id ?? this.id,
        petId: petId ?? this.petId,
        treatmentType: treatmentType ?? this.treatmentType,
        treatmentDate: treatmentDate ?? this.treatmentDate,
        treatmentName: treatmentName ?? this.treatmentName,
        doctorName: doctorName ?? this.doctorName,
        treatmentDescription: treatmentDescription ?? this.treatmentDescription,
        treatmentStatus: treatmentStatus ?? this.treatmentStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

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
