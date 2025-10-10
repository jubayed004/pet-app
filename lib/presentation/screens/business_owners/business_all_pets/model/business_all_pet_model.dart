class BusinessAllPetsModel {
  final bool? success;
  final int? totalPets;
  final List<Pet>? pets;

  BusinessAllPetsModel({
    this.success,
    this.totalPets,
    this.pets,
  });

  BusinessAllPetsModel copyWith({
    bool? success,
    int? totalPets,
    List<Pet>? pets,
  }) =>
      BusinessAllPetsModel(
        success: success ?? this.success,
        totalPets: totalPets ?? this.totalPets,
        pets: pets ?? this.pets,
      );

  factory BusinessAllPetsModel.fromJson(Map<String, dynamic> json) => BusinessAllPetsModel(
    success: json["success"],
    totalPets: json["totalPets"],
    pets: json["pets"] == null ? [] : List<Pet>.from(json["pets"]!.map((x) => Pet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "totalPets": totalPets,
    "pets": pets == null ? [] : List<dynamic>.from(pets!.map((x) => x.toJson())),
  };
}

class Pet {
  final String? petPhoto;
  final String? id;
  final String? name;
  final String? animalType;
  final String? breed;
  final int? age;
  final String? gender;
  final double? weight;
  final int? height;
  final String? color;
  final String? description;
  final UserId? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final List<MedicalHistory>? medicalHistory;

  Pet({
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

  Pet copyWith({
    String? petPhoto,
    String? id,
    String? name,
    String? animalType,
    String? breed,
    int? age,
    String? gender,
    double? weight,
    int? height,
    String? color,
    String? description,
    UserId? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    List<MedicalHistory>? medicalHistory,
  }) =>
      Pet(
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

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
    petPhoto: json["petPhoto"],
    id: json["_id"],
    name: json["name"],
    animalType: json["animalType"],
    breed: json["breed"],
    age: json["age"],
    gender: json["gender"],
    weight: json["weight"]?.toDouble(),
    height: json["height"],
    color: json["color"],
    description: json["description"],
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    medicalHistory: json["medicalHistory"] == null ? [] : List<MedicalHistory>.from(json["medicalHistory"]!.map((x) => MedicalHistory.fromJson(x))),
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
    "userId": userId?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "medicalHistory": medicalHistory == null ? [] : List<dynamic>.from(medicalHistory!.map((x) => x.toJson())),
  };
}

class MedicalHistory {
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

  MedicalHistory({
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

  MedicalHistory copyWith({
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
      MedicalHistory(
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

  factory MedicalHistory.fromJson(Map<String, dynamic> json) => MedicalHistory(
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

class UserId {
  final String? id;
  final String? name;
  final String? email;
  final String? profilePic;

  UserId({
    this.id,
    this.name,
    this.email,
    this.profilePic,
  });

  UserId copyWith({
    String? id,
    String? name,
    String? email,
    String? profilePic,
  }) =>
      UserId(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        profilePic: profilePic ?? this.profilePic,
      );

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    profilePic: json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "profilePic": profilePic,
  };
}
