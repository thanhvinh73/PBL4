part of 'update_profile_screen_cubit.dart';

@freezed
class UpdateProfileScreenState with _$UpdateProfileScreenState {
  const factory UpdateProfileScreenState.initial({
    String? errorMessage,
    @Default(ScreenStatus.init) ScreenStatus status,
    User? currentUser,
  }) = _Initial;
}
