// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'credential.freezed.dart';
part 'credential.g.dart';

@freezed
class Credential with _$Credential {
  const factory Credential({
    @Default('') @JsonKey(name: 'access_token') String accessToken,
    @Default('') @JsonKey(name: 'refresh_token') String refreshToken,
    @JsonKey(name: 'expires_in') int? expiresIn,
  }) = _Credential;
  factory Credential.fromJson(Map<String, dynamic> json) =>
      _$CredentialFromJson(json);
}
