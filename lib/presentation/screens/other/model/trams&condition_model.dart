
class TermsConditionsModel {
  final bool? success;
  final String? message;
  final TermsConditions? termsConditions;

  TermsConditionsModel({
    this.success,
    this.message,
    this.termsConditions,
  });

  factory TermsConditionsModel.fromJson(Map<String, dynamic> json) => TermsConditionsModel(
    success: json["success"],
    message: json["message"],
    termsConditions: json["termsConditions"] == null ? null : TermsConditions.fromJson(json["termsConditions"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "termsConditions": termsConditions?.toJson(),
  };
}

class TermsConditions {
  final String? id;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  TermsConditions({
    this.id,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory TermsConditions.fromJson(Map<String, dynamic> json) => TermsConditions(
    id: json["_id"],
    description: json["description"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "description": description,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
