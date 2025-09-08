class BusinessAllPetsDetailsModel {
  final bool? success;
  final String? message;
  final Pet? pet;
  final List<PetMedicalHistory>? petMedicalHistory;

  BusinessAllPetsDetailsModel({
    this.success,
    this.message,
    this.pet,
    this.petMedicalHistory,
  });

  factory BusinessAllPetsDetailsModel.fromJson(Map<String, dynamic> json) => BusinessAllPetsDetailsModel(
    success: json["success"],
    message: json["message"],
    pet: json["pet"] == null ? null : Pet.fromJson(json["pet"]),
    petMedicalHistory: json["petMedicalHistory"] == null ? [] : List<PetMedicalHistory>.from(json["petMedicalHistory"]!.map((x) => PetMedicalHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "pet": pet?.toJson(),
    "petMedicalHistory": petMedicalHistory == null ? [] : List<dynamic>.from(petMedicalHistory!.map((x) => x.toJson())),
  };
}

class Pet {
  final String? id;
  final String? name;
  final String? animalType;
  final String? breed;
  final int? age;
  final String? gender;
  final int? weight;
  final int? height;
  final String? color;
  final String? description;
  final String? userId;
  final String? petPhoto;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Pet({
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
    this.petPhoto,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
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
    petPhoto: json["petPhoto"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
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
    "petPhoto": petPhoto,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class PetMedicalHistory {
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

  PetMedicalHistory({
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

  factory PetMedicalHistory.fromJson(Map<String, dynamic> json) => PetMedicalHistory(
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
