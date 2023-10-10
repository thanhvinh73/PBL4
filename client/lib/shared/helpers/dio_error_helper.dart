import 'package:client/generated/translations.g.dart';
import 'package:client/services/api_response/api_response.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

String parseError(Object error) {
  String errorDescription = "";
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.cancel:
        errorDescription = tr(LocaleKeys.Error_CancalledApiError);
        break;
      case DioExceptionType.connectionTimeout:
        errorDescription = tr(LocaleKeys.Error_ConnectionTimeoutError);
        break;
      case DioExceptionType.connectionError:
        errorDescription = tr(LocaleKeys.Error_ConnectionError);
        break;
      case DioExceptionType.receiveTimeout:
        errorDescription = tr(LocaleKeys.Error_ReceiveTimeoutError);
        break;

      case DioExceptionType.badResponse:
        try {
          final data = error.response?.data as Map<String, dynamic>;
          final response = ApiResponse.fromJson(data, (p0) => data);
          errorDescription = response.errors?.values
                  .expand((e) => e)
                  .join('\n') ??
              response.message ??
              tr('Error.${'${error.response?.data['error']['code']}'.replaceAll('.', '')}');
        } catch (e) {
          errorDescription = tr(
              'Error.${'${error.response?.data['error']['code']}'.replaceAll('.', '')}');
        }

        break;
      case DioExceptionType.sendTimeout:
        errorDescription = tr(LocaleKeys.Error_SendTimeoutError);
        break;
      case DioExceptionType.badCertificate:
        errorDescription = tr(LocaleKeys.Error_UnexpectedError);
        break;
      case DioExceptionType.unknown:
        errorDescription = tr(LocaleKeys.Error_UnexpectedError);
        break;
    }
  } else {
    errorDescription = tr(LocaleKeys.Error_UnexpectedError);
  }
  return errorDescription;
}
