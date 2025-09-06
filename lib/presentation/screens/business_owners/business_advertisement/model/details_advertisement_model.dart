
class DetailsAdvertisementModel {
  final bool? success;
  final String? message;
  final List<Advertisement>? advertisement;

  DetailsAdvertisementModel({
    this.success,
    this.message,
    this.advertisement,
  });

  factory DetailsAdvertisementModel.fromJson(Map<String, dynamic> json) => DetailsAdvertisementModel(
    success: json["success"],
    message: json["message"],
    advertisement: json["advertisement"] == null ? [] : List<Advertisement>.from(json["advertisement"]!.map((x) => Advertisement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "advertisement": advertisement == null ? [] : List<dynamic>.from(advertisement!.map((x) => x.toJson())),
  };
}

class Advertisement {
  final String? status;
  final String? id;
  final List<String>? advertisementImg;
  final String? businessId;
  final String? ownerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Advertisement({
    this.status,
    this.id,
    this.advertisementImg,
    this.businessId,
    this.ownerId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Advertisement.fromJson(Map<String, dynamic> json) => Advertisement(
    status: json["status"],
    id: json["_id"],
    advertisementImg: json["advertisementImg"] == null ? [] : List<String>.from(json["advertisementImg"]!.map((x) => x)),
    businessId: json["businessId"],
    ownerId: json["ownerId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "_id": id,
    "advertisementImg": advertisementImg == null ? [] : List<dynamic>.from(advertisementImg!.map((x) => x)),
    "businessId": businessId,
    "ownerId": ownerId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
