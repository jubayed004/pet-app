class LoginModel {
  final bool? success;
  final String? message;
  final Data? data;

  LoginModel({
    this.success,
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  final String? accessToken;
  final String? refreshToken;
  final String? profileId;
  final bool? isAdditionalSkillProvided;
  final bool? isMailSkillProvided;
  final bool? isVideosAdded;
  final bool? isPremium;

  Data({
    this.accessToken,
    this.refreshToken,
    this.profileId,
    this.isAdditionalSkillProvided,
    this.isMailSkillProvided,
    this.isVideosAdded,
    this.isPremium,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
    profileId: json["profileId"],
    isAdditionalSkillProvided: json["isAdditionalSkillProvided"],
    isMailSkillProvided: json["isMailSkillProvided"],
    isVideosAdded: json["isVideosAdded"],
    isPremium: json["isPremium"],
  );
}
