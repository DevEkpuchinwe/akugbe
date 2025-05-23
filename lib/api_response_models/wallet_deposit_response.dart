class WalletDepositResponse {
  WalletDepositResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final Data? data;

  factory WalletDepositResponse.fromJson(Map<String, dynamic> json){
    return WalletDepositResponse(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.requestSuccessful,
    required this.responseMessage,
    required this.responseCode,
    required this.responseBody,
  });

  final bool requestSuccessful;
  final String responseMessage;
  final String responseCode;
  final ResponseBody? responseBody;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      requestSuccessful: json["requestSuccessful"] ?? false,
      responseMessage: json["responseMessage"] ?? "",
      responseCode: json["responseCode"] ?? "",
      responseBody: json["responseBody"] == null ? null : ResponseBody.fromJson(json["responseBody"]),
    );
  }

}

class ResponseBody {
  ResponseBody({
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
    required this.bankCode,
    required this.accountDurationSeconds,
    required this.usdPayment,
    required this.requestTime,
    required this.expiresOn,
    required this.transactionReference,
    required this.paymentReference,
    required this.amount,
    required this.fee,
    required this.totalPayable,
    required this.collectionChannel,
    required this.productInformation,
  });

  final String accountNumber;
  final String accountName;
  final String bankName;
  final String bankCode;
  final int accountDurationSeconds;
  final String usdPayment;
  final DateTime? requestTime;
  final DateTime? expiresOn;
  final String transactionReference;
  final String paymentReference;
  final int amount;
  final int fee;
  final int totalPayable;
  final String collectionChannel;
  final dynamic productInformation;

  factory ResponseBody.fromJson(Map<String, dynamic> json){
    return ResponseBody(
      accountNumber: json["accountNumber"] ?? "",
      accountName: json["accountName"] ?? "",
      bankName: json["bankName"] ?? "",
      bankCode: json["bankCode"] ?? "",
      accountDurationSeconds: json["accountDurationSeconds"] ?? 0,
      usdPayment: json["usdPayment"] ?? "",
      requestTime: DateTime.tryParse(json["requestTime"] ?? ""),
      expiresOn: DateTime.tryParse(json["expiresOn"] ?? ""),
      transactionReference: json["transactionReference"] ?? "",
      paymentReference: json["paymentReference"] ?? "",
      amount: json["amount"] ?? 0,
      fee: json["fee"] ?? 0,
      totalPayable: json["totalPayable"] ?? 0,
      collectionChannel: json["collectionChannel"] ?? "",
      productInformation: json["productInformation"],
    );
  }

}
