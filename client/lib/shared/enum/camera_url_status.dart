import 'package:freezed_annotation/freezed_annotation.dart';

enum CameraUrlStatus {
  @JsonValue("ACTIVE")
  active,
  @JsonValue("INACTIVE")
  inactive,
}

extension CameraUrlStatusExt on CameraUrlStatus {
  String get text => {
        // CameraUrlStatus.active: tr(LocaleKeys.aciv),
        // CameraUrlStatus.inactive: tr(LocaleKeys.CameraUrl_Inactive),
      }[this]!;
}
