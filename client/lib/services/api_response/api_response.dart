import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@Freezed(
  genericArgumentFactories: true,
)
class ApiResponse<T> with _$ApiResponse<T> {
  factory ApiResponse({
    int? status,
    String? message,
    T? data,
    Map<String, List<String>>? errors,
  }) = _ApiResponse<T>;

  factory ApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ApiResponseFromJson<T>(json, fromJsonT);
}
