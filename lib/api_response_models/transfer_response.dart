class TransferResponse {
  TransferResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final dynamic data;

  factory TransferResponse.fromJson(Map<String, dynamic> json){
    return TransferResponse(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: json["data"],
    );
  }

}
