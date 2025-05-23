class GetAllBanksResponse {
  GetAllBanksResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<Bank> data;

  factory GetAllBanksResponse.fromJson(Map<String, dynamic> json){
    return GetAllBanksResponse(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Bank>.from(json["data"]!.map((x) => Bank.fromJson(x))),
    );
  }

}

class Bank {
  Bank({
    required this.id,
    required this.name,
    required this.code,
  });

  final int? id;
  final String? name;
  final String? code;

  factory Bank.fromJson(Map<String, dynamic> json){
    return Bank(
      id: json["id"],
      name: json["name"],
      code: json["code"],
    );
  }

}
