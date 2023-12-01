// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LabelOrder _$$_LabelOrderFromJson(Map<String, dynamic> json) =>
    _$_LabelOrder(
      userId: json['userId'] as String?,
      labelOrder: json['label_order'] as String?,
      label: $enumDecodeNullable(_$LabelOrderEnumEnumMap, json['label']),
    );

Map<String, dynamic> _$$_LabelOrderToJson(_$_LabelOrder instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'label_order': instance.labelOrder,
      'label': _$LabelOrderEnumEnumMap[instance.label],
    };

const _$LabelOrderEnumEnumMap = {
  LabelOrderEnum.forward: 'FORWARD',
  LabelOrderEnum.backward: 'BACKWARD',
  LabelOrderEnum.start: 'START',
  LabelOrderEnum.stop: 'STOP',
};
