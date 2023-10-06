part of 'main_screen_cubit.dart';

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState({
    String? errorMessage,
    @Default(ScreenStatus.init) ScreenStatus status,
    @Default(BottomTabs.Home) BottomTabs currentTab,
  }) = _Initial;
}
