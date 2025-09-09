class HomeHeaderModel {
  final bool? success;
  final String? message;
  final Data? data;

  HomeHeaderModel({
    this.success,
    this.message,
    this.data,
  });

  factory HomeHeaderModel.fromJson(Map<String, dynamic> json) => HomeHeaderModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final int? totalPets;
  final List<PetList>? petList;
  final String? userPic;

  Data({
    this.totalPets,
    this.petList,
    this.userPic,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalPets: json["totalPets"],
    petList: json["petList"] == null ? [] : List<PetList>.from(json["petList"]!.map((x) => PetList.fromJson(x))),
    userPic: json["userPic"],
  );

  Map<String, dynamic> toJson() => {
    "totalPets": totalPets,
    "petList": petList == null ? [] : List<dynamic>.from(petList!.map((x) => x.toJson())),
    "userPic": userPic,
  };
}

class PetList {
  final String? id;
  final String? petPhoto;
  final String? name;

  PetList({
    this.id,
    this.petPhoto,
    this.name,
  });

  factory PetList.fromJson(Map<String, dynamic> json) => PetList(
    id: json["_id"],
    petPhoto: json["petPhoto"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "petPhoto": petPhoto,
    "name": name,
  };
}
