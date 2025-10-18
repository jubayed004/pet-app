class BusinessAllPetsDetailsModel {
  final bool? success;
  final String? message;
  final PetWithMedicalHistoryItem? petWithMedicalHistory;

  BusinessAllPetsDetailsModel({
    this.success,
    this.message,
    this.petWithMedicalHistory,
  });

  BusinessAllPetsDetailsModel copyWith({
    bool? success,
    String? message,
    PetWithMedicalHistoryItem? petWithMedicalHistory,
  }) =>
      BusinessAllPetsDetailsModel(
        success: success ?? this.success,
        message: message ?? this.message,
        petWithMedicalHistory: petWithMedicalHistory ?? this.petWithMedicalHistory,
      );

  factory BusinessAllPetsDetailsModel.fromJson(Map<String, dynamic> json) => BusinessAllPetsDetailsModel(
    success: json["success"],
    message: json["message"],
    petWithMedicalHistory: json["petWithMedicalHistory"] == null ? null : PetWithMedicalHistoryItem.fromJson(json["petWithMedicalHistory"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "petWithMedicalHistory": petWithMedicalHistory?.toJson(),
  };
}

class PetWithMedicalHistoryItem {
  final String? petPhoto;
  final String? id;
  final String? name;
  final String? animalType;
  final String? breed;
  final num? age;
  final String? gender;
  final num? weight;
  final num? height;
  final String? color;
  final String? description;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final List<PetMedicalHistory>? medicalHistory;

  PetWithMedicalHistoryItem({
    this.petPhoto,
    this.id,
    this.name,
    this.animalType,
    this.breed,
    this.age,
    this.gender,
    this.weight,
    this.height,
    this.color,
    this.description,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.medicalHistory,
  });

  PetWithMedicalHistoryItem copyWith({
    String? petPhoto,
    String? id,
    String? name,
    String? animalType,
    String? breed,
    num? age,
    String? gender,
    num? weight,
    num? height,
    String? color,
    String? description,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    List<PetMedicalHistory>? medicalHistory,
  }) =>
      PetWithMedicalHistoryItem(
        petPhoto: petPhoto ?? this.petPhoto,
        id: id ?? this.id,
        name: name ?? this.name,
        animalType: animalType ?? this.animalType,
        breed: breed ?? this.breed,
        age: age ?? this.age,
        gender: gender ?? this.gender,
        weight: weight ?? this.weight,
        height: height ?? this.height,
        color: color ?? this.color,
        description: description ?? this.description,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        medicalHistory: medicalHistory ?? this.medicalHistory,
      );

  factory PetWithMedicalHistoryItem.fromJson(Map<String, dynamic> json) => PetWithMedicalHistoryItem(
    petPhoto: json["petPhoto"],
    id: json["_id"],
    name: json["name"],
    animalType: json["animalType"],
    breed: json["breed"],
    age: json["age"],
    gender: json["gender"],
    weight: json["weight"],
    height: json["height"],
    color: json["color"],
    description: json["description"],
    userId: json["userId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    medicalHistory: json["medicalHistory"] == null ? [] : List<PetMedicalHistory>.from(json["medicalHistory"]!.map((x) => PetMedicalHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "petPhoto": petPhoto,
    "_id": id,
    "name": name,
    "animalType": animalType,
    "breed": breed,
    "age": age,
    "gender": gender,
    "weight": weight,
    "height": height,
    "color": color,
    "description": description,
    "userId": userId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "medicalHistory": medicalHistory == null ? [] : List<dynamic>.from(medicalHistory!.map((x) => x.toJson())),
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
