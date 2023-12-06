part of 'detection_screen_cubit.dart';

@freezed
class DetectionScreenState with _$DetectionScreenState {
  const factory DetectionScreenState.initial({
    String? errorMessage,
    required String url,
    required String userId,
    @Default(0) int pan,
    @Default(0) int tilt,
    @Default(false) bool waiting,
    @Default(0) int second,
  }) = _Initial;
}
