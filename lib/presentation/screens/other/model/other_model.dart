

class OtherModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final dynamic data;

  OtherModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory OtherModel.fromJson(Map<String, dynamic> json) => OtherModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data,
  };
}
