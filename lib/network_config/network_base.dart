import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../local_storage/secure_storage.dart';
import '../utils/app_utils.dart';

class NetworkConfig {
  static final NetworkConfig _singleton = NetworkConfig._privateConstructor();

  factory NetworkConfig() => _singleton;

  NetworkConfig._privateConstructor();

  final normalHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'lang': 'en',
  };

  final normalDio = Dio(BaseOptions(
    baseUrl: "https://akugbe.ouchestechnology.com.ng/api/",
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ))
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 1000,
        enabled: true));

  Future<Dio> _getDio(
      {bool needsAuth = false}) async {
    Dio customizedDio = normalDio;
    if (needsAuth) {
      var token = await getAuthToken();

      customizedDio.options.headers["Authorization"] = "bearer $token";
    }

    return customizedDio;
  }

  Future<Response> postReques(String path, Map<String, dynamic>? data,
      {bool needAuth = true,
      Map<String, dynamic>? queryParameters}) async {
    var dio = await _getDio(needsAuth: needAuth);
    final Response response =
        await dio.post(path, data: data, queryParameters: queryParameters);
    return response;
  }

  Future<Response> postReque(String path, dynamic data,
    {bool needAuth = true,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false}) async {
  var dio = await _getDio(needsAuth: needAuth);

  if (isFormData) {
    dio.options.headers['Content-Type'] = 'multipart/form-data';
  } else {
    dio.options.headers['Content-Type'] = 'application/json';
  }

  final Response response =
      await dio.post(path, data: data, queryParameters: queryParameters);

  return response;
}

Future<Response> postRequest(String path, dynamic data,
    {bool needAuth = true,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false}) async {
  var dio = await _getDio(needsAuth: needAuth);

  if (!isFormData) {
    dio.options.headers['Content-Type'] = 'application/json';
  } else {
    // Let Dio set it automatically
    dio.options.headers.remove('Content-Type');
  }

  final Response response =
      await dio.post(path, data: data, queryParameters: queryParameters);

  return response;
}



  Future<Response> getRequest(String path, Map<String, dynamic>? data,
      {bool needAuth = true,
      Map<String, dynamic>? queryParameters}) async {
    var dio = await _getDio(needsAuth: needAuth);
    final Response response =
        await dio.get(path, data: data, queryParameters: queryParameters);
    return response;
  }

  Future<Response> deleteRequest(String path, Map<String, dynamic>? data,
      {bool needAuth = true,
      Map<String, dynamic>? queryParameters}) async {
    var dio = await _getDio(needsAuth: needAuth);
    final Response response =
        await dio.delete(path, data: data, queryParameters: queryParameters);
    return response;
  }

  Future<Response> patchRequest(String path, Map<String, dynamic>? data,
      {bool needAuth = true,
      Map<String, dynamic>? queryParameters}) async {
    var dio = await _getDio(needsAuth: needAuth);
    final Response response =
        await dio.patch(path, data: data, queryParameters: queryParameters);
    return response;
  }

  Future<Response> putRequest(String path, Map<String, dynamic>? data,
      {bool needAuth = true,
      Map<String, dynamic>? queryParameters}) async {
    var dio = await _getDio(needsAuth: needAuth);
    final Response response =
        await dio.put(path, data: data, queryParameters: queryParameters);
    return response;
  }

  Future<Response> uploadRequest(String path, FormData data,
      Function(int sent, int total)? progressListener,
      {bool needAuth = true, Map<String, dynamic>? queryParameters}) async {
    var dio = await _getDio(needsAuth: needAuth);
    final Response response = await dio.post(path,
        data: data,
        queryParameters: queryParameters,
        onSendProgress: progressListener);
    return response;
  }

  Future<Response> downloadRequest(
    String path,
    FormData data,
    String savePath, {
    bool needAuth = true,
    Map<String, dynamic>? queryParameters,
  }) async {
    var dio = await _getDio(needsAuth: needAuth);
    final Response response = await dio.download(path, savePath);
    return response;
  }

  void handleNetworkExceptions(DioException exception) {
    // logout if user is unauthorized.
    if (exception.response?.statusCode == 401 ||
        exception.type == DioExceptionType.cancel) {
      AppUtils.logout();
      return;
    }
  }

  Future<String> getAuthToken() async {
    var token = await SecureStorage().getValue("auth_token");
    return token!;
  }
}
