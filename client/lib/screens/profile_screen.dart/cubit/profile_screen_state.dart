part of 'profile_screen_cubit.dart';

@freezed
class ProfileScreenState with _$ProfileScreenState {
  const factory ProfileScreenState.initial({
    String? errorMessage,
    @Default(ScreenStatus.init) ScreenStatus status,
  }) = _Initial;
}
