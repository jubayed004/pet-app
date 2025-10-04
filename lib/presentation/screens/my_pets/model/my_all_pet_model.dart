
class MyAllPetModel {
  final bool? success;
  final List<Pet>? pet;

  MyAllPetModel({
    this.success,
    this.pet,
  });

  factory MyAllPetModel.fromJson(Map<String, dynamic> json) => MyAllPetModel(
    success: json["success"],
    pet: json["pet"] == null ? [] : List<Pet>.from(json["pet"]!.map((x) => Pet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "pet": pet == null ? [] : List<dynamic>.from(pet!.map((x) => x.toJson())),
  };
}

class Pet {
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
  final String? photo;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? petPhoto;

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
    this.photo,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.petPhoto,
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
    photo: json["photo"],
    userId: json["userId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    petPhoto: json["petPhoto"],
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
    "photo": photo,
    "userId": userId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "petPhoto": petPhoto,
  };
}
