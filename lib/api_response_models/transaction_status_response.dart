class TransactionStatusResponse {
  TransactionStatusResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory TransactionStatusResponse.fromJson(Map<String, dynamic> json){
    return TransactionStatusResponse(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.monifyData,
    required this.transactions,
    required this.balance,
  });

  final MonifyData? monifyData;
  final List<Transaction> transactions;
  final String? balance;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      monifyData: json["monify_data"] == null ? null : MonifyData.fromJson(json["monify_data"]),
      transactions: json["transactions"] == null ? [] : List<Transaction>.from(json["transactions"]!.map((x) => Transaction.fromJson(x))),
      balance: json["balance"],
    );
  }

}

class MonifyData {
  MonifyData({
    required this.requestSuccessful,
    required this.responseMessage,
    required this.responseCode,
    required this.responseBody,
  });

  final bool? requestSuccessful;
  final String? responseMessage;
  final String? responseCode;
  final ResponseBody? responseBody;

  factory MonifyData.fromJson(Map<String, dynamic> json){
    return MonifyData(
      requestSuccessful: json["requestSuccessful"],
      responseMessage: json["responseMessage"],
      responseCode: json["responseCode"],
      responseBody: json["responseBody"] == null ? null : ResponseBody.fromJson(json["responseBody"]),
    );
  }

}

class ResponseBody {
  ResponseBody({
    required this.transactionReference,
    required this.paymentReference,
    required this.amountPaid,
    required this.totalPayable,
    required this.settlementAmount,
    required this.paidOn,
    required this.paymentStatus,
    required this.paymentDescription,
    required this.currency,
    required this.paymentMethod,
    required this.product,
    required this.cardDetails,
    required this.accountDetails,
    required this.accountPayments,
    required this.customer,
    required this.metaData,
  });

  final String? transactionReference;
  final String? paymentReference;
  final String? amountPaid;
  final String? totalPayable;
  final dynamic settlementAmount;
  final dynamic paidOn;
  final String? paymentStatus;
  final String? paymentDescription;
  final String? currency;
  final String? paymentMethod;
  final Product? product;
  final dynamic cardDetails;
  final dynamic accountDetails;
  final List<dynamic> accountPayments;
  final Customer? customer;
  final List<dynamic> metaData;

  factory ResponseBody.fromJson(Map<String, dynamic> json){
    return ResponseBody(
      transactionReference: json["transactionReference"],
      paymentReference: json["paymentReference"],
      amountPaid: json["amountPaid"],
      totalPayable: json["totalPayable"],
      settlementAmount: json["settlementAmount"],
      paidOn: json["paidOn"],
      paymentStatus: json["paymentStatus"],
      paymentDescription: json["paymentDescription"],
      currency: json["currency"],
      paymentMethod: json["paymentMethod"],
      product: json["product"] == null ? null : Product.fromJson(json["product"]),
      cardDetails: json["cardDetails"],
      accountDetails: json["accountDetails"],
      accountPayments: json["accountPayments"] == null ? [] : List<dynamic>.from(json["accountPayments"]!.map((x) => x)),
      customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
      metaData: json["metaData"] == null ? [] : List<dynamic>.from(json["metaData"]!.map((x) => x)),
    );
  }

}

class Customer {
  Customer({
    required this.email,
    required this.name,
  });

  final String? email;
  final String? name;

  factory Customer.fromJson(Map<String, dynamic> json){
    return Customer(
      email: json["email"],
      name: json["name"],
    );
  }

}

class Product {
  Product({
    required this.type,
    required this.reference,
  });

  final String? type;
  final String? reference;

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      type: json["type"],
      reference: json["reference"],
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

  final int? id;
  final int? walletId;
  final String? referenceNumber;
  final String? type;
  final String? amount;
  final String? status;
  final String? details;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Transaction.fromJson(Map<String, dynamic> json){
    return Transaction(
      id: json["id"],
      walletId: json["wallet_id"],
      referenceNumber: json["reference_number"],
      type: json["type"],
      amount: json["amount"],
      status: json["status"],
      details: json["details"],
      userId: json["user_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
