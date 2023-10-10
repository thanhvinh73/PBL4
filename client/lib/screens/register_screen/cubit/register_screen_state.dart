part of 'register_screen_cubit.dart';

@freezed
class RegisterScreenState with _$RegisterScreenState {
  const factory RegisterScreenState.initial({
    String? username,
    String? password,
    String? confirmPassword,
    String? email,
    String? errorMessage,
    User? user,
    @Default(ScreenStatus.init) ScreenStatus status,
  }) = _Initial;
}
