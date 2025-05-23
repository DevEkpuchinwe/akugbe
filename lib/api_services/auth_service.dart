import 'package:akugbe/api_response_models/forgot_password_response.dart';
import 'package:akugbe/api_response_models/login_response.dart';
import 'package:akugbe/api_response_models/reset_password_response.dart';
import 'package:akugbe/api_response_models/resgister_response.dart';
import 'package:dio/dio.dart';

import '../network_config/network_base.dart';

mixin AuthService {
  static const registerPath = "register";
  static const forgotPasswordPath = "forgot-password";
  static const resetPasswordPath = "reset-password";
  static const loginPath = "login";

  Future<RegisterResponse> register(Map<String, dynamic> data) async {
    try {
      var response = await NetworkConfig()
          .postRequest(registerPath, data, needAuth: false);
      if ("${response.statusCode}".startsWith("2")) {
        return RegisterResponse.fromJson(response.data);
      } else {
        throw Exception("An error occurred");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Oops. Check your internet connection and try again.");
      } else if (e.type == DioExceptionType.badResponse) {
        return RegisterResponse.fromJson(e.response!.data);
      } else {
        throw Exception("An error occurred");
      }
    }
  }

  Future<ForgotPasswordResponse> forgotPassword(
      Map<String, dynamic> data) async {
    try {
      var response = await NetworkConfig()
          .postRequest(forgotPasswordPath, data, needAuth: false);

      if ("${response.statusCode}".startsWith("2")) {
        return ForgotPasswordResponse.fromJson(response.data);
      } else {
        throw Exception("An error occurred");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Oops. Check your internet connection and try again.");
      } else if (e.type == DioExceptionType.badResponse) {
        return ForgotPasswordResponse.fromJson(e.response!.data);
      } else {
        throw Exception("An error occurred");
      }
    }
  }

  Future<ResetPasswordResponse> callResetPassword(
      Map<String, dynamic> data) async {
    try {
      var response = await NetworkConfig()
          .postRequest(resetPasswordPath, data, needAuth: false);

      if ("${response.statusCode}".startsWith("2")) {
        return ResetPasswordResponse.fromJson(response.data);
      } else {
        throw Exception("An error occurred");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Oops. Check your internet connection and try again.");
      } else if (e.type == DioExceptionType.badResponse) {
        return ResetPasswordResponse.fromJson(e.response!.data);
      } else {
        throw Exception("An error occurred");
      }
    }
  }

  Future<LoginResponse> login(Map<String, dynamic> data) async {
    try {
      var response =
          await NetworkConfig().postRequest(loginPath, data, needAuth: false);
      if ("${response.statusCode}".startsWith("2")) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw Exception("An error occurred");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Oops. Check your internet connection and try again.");
      } else if (e.type == DioExceptionType.badResponse) {
        return LoginResponse.fromJson(e.response!.data);
      } else {
        throw Exception("An error occurred");
      }
    }
  }
}
