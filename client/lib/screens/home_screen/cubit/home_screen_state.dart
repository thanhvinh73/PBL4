part of 'home_screen_cubit.dart';

@freezed
class HomeScreenState with _$HomeScreenState {
  const factory HomeScreenState.initial({
    String? errorMessage,
    @Default(ScreenStatus.init) ScreenStatus status,
    @Default("") String text,
    @Default([]) List<CameraUrl> cameraUrls,
    CameraUrl? currentUrl,
  }) = _Initial;
}
