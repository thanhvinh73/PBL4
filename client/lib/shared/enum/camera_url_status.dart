import 'package:client/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum CameraUrlStatus {
  @JsonValue("ACTIVE")
  active,
  @JsonValue("INACTIVE")
  inactive,
}

extension CameraUrlStatusExt on CameraUrlStatus {
  String get text => {
        CameraUrlStatus.active: tr(LocaleKeys.CameraUrl_Active),
        CameraUrlStatus.inactive: tr(LocaleKeys.CameraUrl_Inactive),
      }[this]!;
}
