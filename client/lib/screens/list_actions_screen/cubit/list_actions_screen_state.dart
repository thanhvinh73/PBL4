part of 'list_actions_screen_cubit.dart';

@freezed
class ListActionsScreenState with _$ListActionsScreenState {
  const factory ListActionsScreenState.initial({
    String? errorMessage,
    @Default(ScreenStatus.init) ScreenStatus status,
    List<LabelOrder>? labelOrders,
    required String userId,
  }) = _Initial;
}
