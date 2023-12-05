// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../shared/enum/camera_url_status.dart';

part 'camera_url.g.dart';
part 'camera_url.freezed.dart';

@freezed
class CameraUrl with _$CameraUrl {
  const factory CameraUrl({
    String? id,
    String? url,
    @JsonKey(name: "create_at") int? createAt,
    CameraUrlStatus? status,
    String? ssid,
  }) = _CameraUrl;
  factory CameraUrl.fromJson(Map<String, dynamic> json) =>
      _$CameraUrlFromJson(json);
}
