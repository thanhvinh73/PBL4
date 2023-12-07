import 'package:client/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum LabelOrderEnum {
  @JsonValue("FORWARD")
  forward,
  @JsonValue("BACKWARD")
  backward,
  @JsonValue("START")
  start,
  @JsonValue("STOP")
  stop,
}

extension LabelOrderEnumExt on LabelOrderEnum {
  String get description => {
        LabelOrderEnum.forward: tr(LocaleKeys.ActionDescription_Forward),
        LabelOrderEnum.backward: tr(LocaleKeys.ActionDescription_Backward),
        LabelOrderEnum.start: tr(LocaleKeys.ActionDescription_Start),
        LabelOrderEnum.stop: tr(LocaleKeys.ActionDescription_Stop)
      }[this]!;
}
