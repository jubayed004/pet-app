
class BusinessAllPetsModel {
  final bool? success;
  final int? totalPets;
  final List<Pet>? pets;

  BusinessAllPetsModel({
    this.success,
    this.totalPets,
    this.pets,
  });

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
  final String? photo;
  final String? userId;
  final List<String>? petPhoto;
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
    this.photo,
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
    photo: json["photo"],
    userId: json["userId"],
    petPhoto: json["petPhoto"] == null ? [] : List<String>.from(json["petPhoto"]!.map((x) => x)),
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
    "photo": photo,
    "userId": userId,
    "petPhoto": petPhoto == null ? [] : List<dynamic>.from(petPhoto!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
