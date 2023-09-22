part of 'splash_screen_cubit.dart';

@freezed
class SplashScreenState with _$SplashScreenState {
  const factory SplashScreenState(
      {String? baseUrl,
      String? errorMessage,
      @Default(false) bool isConfirmed}) = _Initial;
}
