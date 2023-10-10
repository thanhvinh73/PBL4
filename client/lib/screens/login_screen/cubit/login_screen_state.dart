part of 'login_screen_cubit.dart';

@freezed
class LoginScreenState with _$LoginScreenState {
  const factory LoginScreenState.initial({
    String? username,
    String? password,
    String? errorMessage,
    User? user,
    @Default(ScreenStatus.init) ScreenStatus status,
  }) = _Initial;
}
