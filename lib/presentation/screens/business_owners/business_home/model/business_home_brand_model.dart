class BusinessHomeBrandModel {
  final bool? success;
  final String? message;
  final List<TopBrand>? topBrands;

  BusinessHomeBrandModel({
    this.success,
    this.message,
    this.topBrands,
  });

  BusinessHomeBrandModel copyWith({
    bool? success,
    String? message,
    List<TopBrand>? topBrands,
  }) =>
      BusinessHomeBrandModel(
        success: success ?? this.success,
        message: message ?? this.message,
        topBrands: topBrands ?? this.topBrands,
      );

  factory BusinessHomeBrandModel.fromJson(Map<String, dynamic> json) => BusinessHomeBrandModel(
    success: json["success"],
    message: json["message"],
    topBrands: json["topBrands"] == null ? [] : List<TopBrand>.from(json["topBrands"]!.map((x) => TopBrand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "topBrands": topBrands == null ? [] : List<dynamic>.from(topBrands!.map((x) => x.toJson())),
  };
}

class TopBrand {
  final String? id;
  final List<String>? logo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  TopBrand({
    this.id,
    this.logo,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  TopBrand copyWith({
    String? id,
    List<String>? logo,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      TopBrand(
        id: id ?? this.id,
        logo: logo ?? this.logo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory TopBrand.fromJson(Map<String, dynamic> json) => TopBrand(
    id: json["_id"],
    logo: json["logo"] == null ? [] : List<String>.from(json["logo"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "logo": logo == null ? [] : List<dynamic>.from(logo!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
