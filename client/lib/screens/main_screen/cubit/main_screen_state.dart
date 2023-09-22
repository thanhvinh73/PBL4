part of 'main_screen_cubit.dart';

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState(
      {String? errorMessage, required String baseUrl}) = _Initial;
}
