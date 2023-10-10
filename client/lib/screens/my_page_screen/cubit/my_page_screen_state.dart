part of 'my_page_screen_cubit.dart';

@freezed
class MyPageScreenState with _$MyPageScreenState {
  const factory MyPageScreenState.initial({
    String? errorMessage,
    @Default(false) bool isLogout,
  }) = _Initial;
}
