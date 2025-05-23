class ApiErrorModel {
  ApiErrorModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final Message? message;
  final dynamic data;

  factory ApiErrorModel.fromJson(Map<String, dynamic> json){
    return ApiErrorModel(
      status: json["status"] ?? false,
      message: json["message"] == null ? null : Message.fromJson(json["message"]),
      data: json["data"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message?.toJson(),
    "data": data,
  };

}

class Message {
  Message({
    required this.username,
  });

  final List<String> username;

  factory Message.fromJson(Map<String, dynamic> json){
    return Message(
      username: json["username"] == null ? [] : List<String>.from(json["username"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "username": username.map((x) => x).toList(),
  };

}
