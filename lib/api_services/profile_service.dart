import 'package:akugbe/api_response_models/profie_response_model.dart';
import 'package:dio/dio.dart';

import '../network_config/network_base.dart';

mixin ProfileService{

  Future<ProfileResponseModel> getUserProfile() async {
    try {
      var response = await NetworkConfig()
          .getRequest("profile", null, needAuth: true);
      if ("${response.statusCode}".startsWith("2")) {
        return ProfileResponseModel.fromJson(response.data);
      } else {
        throw Exception("An error occurred");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Oops. Check your internet connection and try again.");
      } else if (e.type == DioExceptionType.badResponse) {
        return ProfileResponseModel.fromJson(e.response!.data);
      } else {
        throw Exception("An error occurred");
      }
    }
  }
}