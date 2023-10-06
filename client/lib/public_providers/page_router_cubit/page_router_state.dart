part of 'page_router_cubit.dart';

@freezed
class PageRouterState with _$PageRouterState {
  const factory PageRouterState.initial({
    String? previousPageName,
    dynamic previousPageArgs,
    String? currentPageName,
    dynamic currentPageArgs,
  }) = _Initial;
}
