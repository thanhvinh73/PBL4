part of 'splash_screen_cubit.dart';

@freezed
class SplashScreenState with _$SplashScreenState {
  const factory SplashScreenState(
      {String? errorMessage, @Default(false) bool isInit}) = _Initial;
}
