part of 'camera_controller_screen_cubit.dart';

@freezed
class CameraControllerScreenState with _$CameraControllerScreenState {
  const factory CameraControllerScreenState.initial({
    @Default(0) int pan,
    @Default(0) int tilt,
    String? errorMessage,
  }) = _Initial;
}
