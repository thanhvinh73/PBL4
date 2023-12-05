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
