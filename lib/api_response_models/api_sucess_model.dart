class ApiSuccessResponseModel {
  ApiSuccessResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final dynamic data;

  factory ApiSuccessResponseModel.fromJson(Map<String, dynamic> json){
    return ApiSuccessResponseModel(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: json["data"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };

}
