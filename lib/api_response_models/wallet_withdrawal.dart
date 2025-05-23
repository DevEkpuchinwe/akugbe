class WalletWithdrawalResponse {
  WalletWithdrawalResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final dynamic data;

  factory WalletWithdrawalResponse.fromJson(Map<String, dynamic> json){
    return WalletWithdrawalResponse(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: json["data"],
    );
  }

}
