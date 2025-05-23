class RegisterResponse {
  RegisterResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final Data? data;

  factory RegisterResponse.fromJson(Map<String, dynamic> json){
    return RegisterResponse(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };

}

class Data {
  Data({
    required this.userId,
  });

  final int userId;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      userId: json["user_id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "user_id": userId,
  };

}
