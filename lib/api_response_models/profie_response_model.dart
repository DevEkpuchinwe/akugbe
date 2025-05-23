class ProfileResponseModel {
  ProfileResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json){
    return ProfileResponseModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
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
    required this.isSuspended,
    required this.suspensionReason,
    required this.reportedCount,
    required this.noOfPosts,
    required this.noOfKliks,
    required this.followers,
    required this.following,
    required this.twoFactorSecret,
    required this.isFrozen,
    required this.profile,
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
  final int? isSuspended;
  final dynamic suspensionReason;
  final int? reportedCount;
  final int? noOfPosts;
  final int? noOfKliks;
  final int? followers;
  final int? following;
  final dynamic twoFactorSecret;
  final int? isFrozen;
  final Profile? profile;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
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
      isSuspended: json["is_suspended"],
      suspensionReason: json["suspension_reason"],
      reportedCount: json["reported_count"],
      noOfPosts: json["no_of_posts"],
      noOfKliks: json["no_of_kliks"],
      followers: json["followers"],
      following: json["following"],
      twoFactorSecret: json["two_factor_secret"],
      isFrozen: json["is_frozen"],
      profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
    );
  }

}

class Profile {
  Profile({
    required this.id,
    required this.userId,
    required this.username,
    required this.privacyPolicy,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? userId;
  final dynamic username;
  final int? privacyPolicy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Profile.fromJson(Map<String, dynamic> json){
    return Profile(
      id: json["id"],
      userId: json["user_id"],
      username: json["username"],
      privacyPolicy: json["privacy_policy"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
