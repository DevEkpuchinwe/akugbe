class WalletBalanceModel {
  WalletBalanceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final Data? data;

  factory WalletBalanceModel.fromJson(Map<String, dynamic> json){
    return WalletBalanceModel(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.balance,
    required this.transaction,
  });

  final String balance;
  final List<Transaction> transaction;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      balance: json["balance"] ?? "",
      transaction: json["transaction"] == null ? [] : List<Transaction>.from(json["transaction"]!.map((x) => Transaction.fromJson(x))),
    );
  }

}

class Transaction {
  Transaction({
    required this.id,
    required this.walletId,
    required this.referenceNumber,
    required this.type,
    required this.amount,
    required this.status,
    required this.details,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int walletId;
  final String referenceNumber;
  final String type;
  final String amount;
  final String status;
  final String details;
  final int userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Transaction.fromJson(Map<String, dynamic> json){
    return Transaction(
      id: json["id"] ?? 0,
      walletId: json["wallet_id"] ?? 0,
      referenceNumber: json["reference_number"] ?? "",
      type: json["type"] ?? "",
      amount: json["amount"] ?? "",
      status: json["status"] ?? "",
      details: json["details"] ?? "",
      userId: json["user_id"] ?? 0,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
