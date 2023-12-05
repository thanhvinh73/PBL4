part of 'setting_controller_screen_cubit.dart';

@freezed
class SettingControllerScreenState with _$SettingControllerScreenState {
  const factory SettingControllerScreenState.initial({
    @Default(0) int pan,
    @Default(0) int tilt,
  }) = _Initial;
}
