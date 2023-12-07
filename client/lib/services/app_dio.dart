import 'package:client/models/credential/credential.dart';
import 'package:client/services/api_response/api_response.dart';
import 'package:client/services/public_api.dart';
import 'package:client/shared/extensions/string_ext.dart';
import 'package:client/shared/utils/shared_preference.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppDio with DioMixin implements Dio {
  AppDio() {
    options = BaseOptions(
        connectTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          'Content-Type': "application/json",
        });
    if (kDebugMode) {
      interceptors.add(
        PrettyDioLogger(requestBody: true, requestHeader: true),
      );
    }

    interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        String? token = sp.prefs.getString('access_token');
        debugPrint("CHECK IS_RF_TOKEN: ${sp.isRefreshToken}");
        if (sp.isRefreshToken) token = sp.refreshToken;
        if (token.isNotEmptyOrNull) {
          debugPrint("DIO-CHECK-TOKEN: $token");
          options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (error, handler) async {
        if (error.response != null) {
          if (error.requestOptions.headers.containsKey('Authorization')) {
            if (error.response?.data is Map &&
                error.response?.data['error'] is Map &&
                error.response?.data['error']['code'] == 'ERR.TOK002') {
              Credential? newToken = await _refreshToken();
              if (newToken != null) {
                error.requestOptions.headers["Authorization"] =
                    'Bearer ${newToken.accessToken}';
                return handler.resolve(await fetch(error.requestOptions));
              }
            }
            if (error.response?.data is Map &&
                error.response?.data['error'] is Map &&
                (error.response?.data['error']['code'] == 'ERR.TOK0101' ||
                    error.response?.data['error']['code'] == 'ERR.TOK0103')) {
              sp.prefs.clear();
            }
            handler.next(error);
          } else {
            handler.next(error);
          }
        } else {
          handler.next(error);
        }
      },
    ));
    httpClientAdapter = HttpClientAdapter();
  }
  Future<Credential?> _refreshToken() async {
    try {
      String? rfToken = sp.refreshToken;
      if (rfToken.isEmptyOrNull) return null;

      await sp.prefs.setBool("is_refresh_token", true);
      final result = await fetch<Map<String, dynamic>>(RequestOptions(
        path: "${PublicApi.baseUrl}/api/auth/refresh_token",
        method: "POST",
      ));

      await sp.clear();
      final value = ApiResponse<Credential>.fromJson(result.data!,
          (json) => Credential.fromJson(json as Map<String, dynamic>));

      await sp.prefs.setBool("is_refresh_token", false);
      if (value.data != null) {
        await sp.setToken(value.data!.accessToken, value.data!.refreshToken);
        return value.data;
      }
      return null;
    } catch (err) {
      await sp.prefs.setBool("is_refresh_token", false);
      return null;
    }
  }
}
