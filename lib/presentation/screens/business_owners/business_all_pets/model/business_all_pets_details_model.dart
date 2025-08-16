
class BusinessAllPetsDetailsModel {
  final bool? success;
  final String? message;
  final Pet? pet;

  BusinessAllPetsDetailsModel({
    this.success,
    this.message,
    this.pet,
  });

  factory BusinessAllPetsDetailsModel.fromJson(Map<String, dynamic> json) => BusinessAllPetsDetailsModel(
    success: json["success"],
    message: json["message"],
    pet: json["pet"] == null ? null : Pet.fromJson(json["pet"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "pet": pet?.toJson(),
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
