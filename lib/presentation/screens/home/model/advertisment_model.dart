class AdvertisementModel {
  final bool? success;
  final String? message;
  final Pagination? pagination;
  final List<Ad>? ads;
  final List<List<String>>? adsPic;

  AdvertisementModel({
    this.success,
    this.message,
    this.pagination,
    this.ads,
    this.adsPic,
  });

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) => AdvertisementModel(
    success: json["success"],
    message: json["message"],
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    ads: json["ads"] == null ? [] : List<Ad>.from(json["ads"]!.map((x) => Ad.fromJson(x))),
    adsPic: json["adsPic"] == null ? [] : List<List<String>>.from(json["adsPic"]!.map((x) => List<String>.from(x.map((x) => x)))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "pagination": pagination?.toJson(),
    "ads": ads == null ? [] : List<dynamic>.from(ads!.map((x) => x.toJson())),
    "adsPic": adsPic == null ? [] : List<dynamic>.from(adsPic!.map((x) => List<dynamic>.from(x.map((x) => x)))),
  };
}

class Ad {
  final String? id;
  final List<String>? advertisementImg;
  final String? businessId;
  final String? ownerId;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Ad({
    this.id,
    this.advertisementImg,
    this.businessId,
    this.ownerId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
    id: json["_id"],
    advertisementImg: json["advertisementImg"] == null ? [] : List<String>.from(json["advertisementImg"]!.map((x) => x)),
    businessId: json["businessId"],
    ownerId: json["ownerId"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "advertisementImg": advertisementImg == null ? [] : List<dynamic>.from(advertisementImg!.map((x) => x)),
    "businessId": businessId,
    "ownerId": ownerId,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Pagination {
  final int? totalAds;
  final int? currentPage;
  final int? totalPages;
  final int? limit;

  Pagination({
    this.totalAds,
    this.currentPage,
    this.totalPages,
    this.limit,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalAds: json["totalAds"],
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "totalAds": totalAds,
    "currentPage": currentPage,
    "totalPages": totalPages,
    "limit": limit,
  };
}
