class LoginResponse {
  LoginResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory LoginResponse.fromJson(Map<String, dynamic> json){
    return LoginResponse(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.user,
    required this.token,
    required this.wallet,
  });

  final User? user;
  final String? token;
  final Wallet? wallet;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      token: json["token"],
      wallet: json["wallet"] == null ? null : Wallet.fromJson(json["wallet"]),
    );
  }

}

class User {
  User({
    required this.id,
    required this.username,
    required this.fullname,
    required this.dateOfBirth,
    required this.gender,
    required this.country,
    required this.phone,
    required this.profileImage,
    required this.interest,
    required this.email,
    required this.emailVerifiedAt,
    required this.otpCode,
    required this.otpExpireAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? username;
  final String? fullname;
  final DateTime? dateOfBirth;
  final String? gender;
  final dynamic country;
  final dynamic phone;
  final dynamic profileImage;
  final dynamic interest;
  final String? email;
  final dynamic emailVerifiedAt;
  final dynamic otpCode;
  final dynamic otpExpireAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      username: json["username"],
      fullname: json["fullname"],
      dateOfBirth: DateTime.tryParse(json["date_of_birth"] ?? ""),
      gender: json["gender"],
      country: json["country"],
      phone: json["phone"],
      profileImage: json["profile_image"],
      interest: json["interest"],
      email: json["email"],
      emailVerifiedAt: json["email_verified_at"],
      otpCode: json["otp_code"],
      otpExpireAt: json["otp_expire_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class Wallet {
  Wallet({
    required this.userId,
    required this.name,
    required this.balance,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  final int? userId;
  final String? name;
  final String? balance;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  factory Wallet.fromJson(Map<String, dynamic> json){
    return Wallet(
      userId: json["user_id"],
      name: json["name"],
      balance: json["balance"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      id: json["id"],
    );
  }

}
