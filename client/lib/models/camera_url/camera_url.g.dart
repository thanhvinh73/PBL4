// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_url.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CameraUrl _$$_CameraUrlFromJson(Map<String, dynamic> json) => _$_CameraUrl(
      id: json['id'] as String?,
      url: json['url'] as String?,
      createAt: json['create_at'] as int?,
      status: $enumDecodeNullable(_$CameraUrlStatusEnumMap, json['status']),
      ssid: json['ssid'] as String?,
    );

Map<String, dynamic> _$$_CameraUrlToJson(_$_CameraUrl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'create_at': instance.createAt,
      'status': _$CameraUrlStatusEnumMap[instance.status],
      'ssid': instance.ssid,
    };

const _$CameraUrlStatusEnumMap = {
  CameraUrlStatus.active: 'ACTIVE',
  CameraUrlStatus.inactive: 'INACTIVE',
};
