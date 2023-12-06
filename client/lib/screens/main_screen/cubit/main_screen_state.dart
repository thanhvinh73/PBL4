part of 'main_screen_cubit.dart';

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState({
    String? errorMessage,
    @Default(ScreenStatus.init) ScreenStatus status,
    @Default(MainTabs.tutorial) MainTabs currentTab,
  }) = _Initial;
}
