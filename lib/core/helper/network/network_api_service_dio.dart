import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream4videos/features/share_pref/user_provider.dart';

import 'app_interceptor.dart';
import 'base_api_service.dart';
import 'api_exception.dart';

class NetworkApiServicesDio extends BaseApiServices {
  final Ref _ref;
  late Dio _dio;

  NetworkApiServicesDio(this._ref) {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        // headers: {
        //   'Content-Type': 'application/json; charset=UTF-8',
        // },
      ),
    );
    _dio.interceptors.addAll([
      AppInterceptor(_ref),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    ]);  }


  // Future<void> _checkInternet() async {
  //   if (!await NetworkChecker.hasInternet()) {
  //     throw FetchDataException("No internet connection");
  //   }
  // }


  /// Common headers with token
  Map<String, String> _getHeadersWithToken() {
    final user = _ref.read(userProvider);
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    if (user != null &&  user.token !=null &&  user.token!.isNotEmpty) {
      headers['Authorization'] = 'Bearer ${user.token}';
    }
    return headers;
  }

  @override
  Future<dynamic> getGetApiResponse(String url,
      {Map<String, dynamic>? queryParameters}) async {
    // await _checkInternet();
    try {
      final response =
      await _dio.get(url, queryParameters: queryParameters);
      return _returnResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<dynamic> getPostApiResponse(
      String url,
      dynamic data, {
        Map<String, dynamic>? queryParameters,
      }) async {
    // await _checkInternet();
    try {
      final response =
      await _dio.post(url, data: data, queryParameters: queryParameters);
      return _returnResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<dynamic> getPutApiResponse(
      String url,
      dynamic data, {
        Map<String, dynamic>? queryParameters,
      }) async {
    // await _checkInternet();
    try {
      final response =
      await _dio.put(url, data: data, queryParameters: queryParameters);
      return _returnResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<dynamic> getPatchApiResponse(String url, dynamic data, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.patch(url, data: data, queryParameters: queryParameters, options: Options(headers: _getHeadersWithToken()));
      return _returnResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<dynamic> getDeleteApiResponse(
      String url, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
      }) async {
    // await _checkInternet();
    try {
      final response =
      await _dio.delete(url, data: data, queryParameters: queryParameters);
      return _returnResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<dynamic> getFormDataApiResponse(
      String url,
      FormData formData, {
        Map<String, dynamic>? queryParameters,
      }) async {
    // await _checkInternet();
    try {
      final response =
      await _dio.post(url, data: formData, queryParameters: queryParameters);
      return _returnResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  dynamic _returnResponse(Response response) {
    // if (kDebugMode) {
    //   debugPrint('Status: ${response.statusCode}, Data: ${response.data}');
    // }
    final statusCode = response.statusCode ?? 500;
    switch (statusCode) {
      case 200:
      case 201:
      case 202:
        return response.data;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        // _ref.read(userProvider.notifier).clearUser();
        // _ref.read(driverOnOffNotifierProvider.notifier).forceOfflineOnLogout();
        throw UnauthorisedException("Unauthorised: ${response.data}");
      case 404:
        throw NotFoundException("Not found: ${response.data}");


      case 409:
        throw ConflictException("$statusCode");

      case 429:
        throw TooManyRequestsException();
      case 500:
        throw FetchDataException("Server Error: ${response.data}");
      case 502:
        throw BadGatewayException();
      case 503:
        throw ServiceUnavailableException();
      case 504:
        throw GatewayTimeoutException();
      default:
        throw FetchDataException("Unexpected Error [$statusCode]: ${response.data}");
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return RequestTimeoutException();

      case DioExceptionType.connectionError:
        return FetchDataException("No internet connection");

      case DioExceptionType.badResponse:
        return FetchDataException(
          e.response?.data?['message'] ?? "Invalid server response",
        );

      case DioExceptionType.cancel:
        return FetchDataException("Request cancelled");

      default:
        return FetchDataException("Unexpected error");
    }
  }}
