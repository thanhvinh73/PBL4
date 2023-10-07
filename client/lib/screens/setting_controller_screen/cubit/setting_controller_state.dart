part of 'setting_controller_cubit.dart';

@freezed
class SettingControllerState with _$SettingControllerState {
  const factory SettingControllerState.initial({
    @Default(false) bool onCamera,
    @Default(false) bool isCameraInitialized,
  }) = _Initial;
}
