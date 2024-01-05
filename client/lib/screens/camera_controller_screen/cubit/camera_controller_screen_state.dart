part of 'camera_controller_screen_cubit.dart';

@freezed
class CameraControllerScreenState with _$CameraControllerScreenState {
  const factory CameraControllerScreenState.initial({
    @Default(90) int pan,
    @Default(90) int tilt,
    String? errorMessage,
  }) = _Initial;
}
