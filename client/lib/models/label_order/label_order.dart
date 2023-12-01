// ignore_for_file: invalid_annotation_target

import 'package:client/shared/enum/label_order.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'label_order.g.dart';
part 'label_order.freezed.dart';

@freezed
class LabelOrder with _$LabelOrder {
  const factory LabelOrder({
    String? userId,
    @JsonKey(name: "label_order") String? labelOrder,
    LabelOrderEnum? label,
  }) = _LabelOrder;
  factory LabelOrder.fromJson(Map<String, dynamic> json) =>
      _$LabelOrderFromJson(json);
}
