part of 'app_user_cubit.dart';

@freezed
class AppUserState with _$AppUserState {
  const factory AppUserState.initial({
    User? user,
    bool? checkInternet,
    CameraUrl? currentCameraUrl,
  }) = _Initial;
}
