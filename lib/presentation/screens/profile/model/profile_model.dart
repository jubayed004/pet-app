
class ProfileModel {
  final bool? success;
  final User? user;
  final List<Pet>? pet;

  ProfileModel({
    this.success,
    this.user,
    this.pet,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    success: json["success"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    pet: json["pet"] == null ? [] : List<Pet>.from(json["pet"]!.map((x) => Pet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "user": user?.toJson(),
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

class User {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? role;
  final bool? isVerified;
  final List<String>? pets;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final bool? isBlocked;
  final String? address;
  final String? profilePic;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.isVerified,
    this.pets,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isBlocked,
    this.address,
    this.profilePic,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    role: json["role"],
    isVerified: json["isVerified"],
    pets: json["pets"] == null ? [] : List<String>.from(json["pets"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    isBlocked: json["isBlocked"],
    address: json["address"],
    profilePic: json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "role": role,
    "isVerified": isVerified,
    "pets": pets == null ? [] : List<dynamic>.from(pets!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "isBlocked": isBlocked,
    "address": address,
    "profilePic": profilePic,
  };
}
