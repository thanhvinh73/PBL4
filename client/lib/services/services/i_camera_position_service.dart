import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class ICameraPositionService {
  Future rotatePan(int pan);
  Future rotateTilt(int tilt);
}

class CameraPositionService implements ICameraPositionService {
  final Dio _dio;
  final String baseUrl;

  CameraPositionService({
    required this.baseUrl,
  }) : _dio = Dio(BaseOptions(
            baseUrl: "http://$baseUrl",
            connectTimeout: const Duration(seconds: 60),
            sendTimeout: const Duration(seconds: 60),
            receiveTimeout: const Duration(seconds: 60),
            headers: {
              'Content-Type': "application/json",
            })) {
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          error: true,
          responseBody: false,
        ),
      );
    }
  }

  @override
  Future rotatePan(int pan) async {
    try {
      const String url = "/action";
      await _dio.fetch(
          RequestOptions(baseUrl: "http://$baseUrl/$url", queryParameters: {
        "pan": pan,
      }));
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future rotateTilt(int tilt) async {
    try {
      const String url = "/action";
      await _dio.fetch(
          RequestOptions(baseUrl: "http://$baseUrl/$url", queryParameters: {
        "tilt": tilt,
      }));
    } catch (err) {
      rethrow;
    }
  }
}
