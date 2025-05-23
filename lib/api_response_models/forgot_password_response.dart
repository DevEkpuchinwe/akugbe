class ForgotPasswordResponse {
  ForgotPasswordResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final dynamic data;

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json){
    return ForgotPasswordResponse(
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
