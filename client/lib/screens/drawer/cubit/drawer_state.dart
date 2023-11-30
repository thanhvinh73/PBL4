part of 'drawer_cubit.dart';

@freezed
class DrawerState with _$DrawerState {
  const factory DrawerState.initial({
    @Default(ScreenStatus.init) ScreenStatus status,
    String? errorMessage,
  }) = _Initial;
}
