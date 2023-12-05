import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class ICameraPositionService {
  Future rotateCamera(double pan, double tilt);
}

class CameraPositionService implements ICameraPositionService {
  final Dio _dio;
  final String baseUrl;

  CameraPositionService({
    required this.baseUrl,
  }) : _dio = Dio(BaseOptions(
            baseUrl: baseUrl,
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
  Future rotateCamera(double pan, double tilt) async {
    const String url = "/";
    await _dio.fetch(RequestOptions(baseUrl: url, queryParameters: {
      "pan": pan,
      "tilt": tilt,
    }));
  }
}
