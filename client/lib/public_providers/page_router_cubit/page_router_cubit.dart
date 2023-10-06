import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_router_state.dart';
part 'page_router_cubit.freezed.dart';

class PageRouterCubit extends Cubit<PageRouterState> {
  PageRouterCubit() : super(const PageRouterState.initial());
  updatePage({required String? name, dynamic args}) {
    debugPrint('Navigate to page $name\n Argument: $args');
    emit(state.copyWith(
        previousPageName: state.currentPageName,
        previousPageArgs: state.currentPageArgs,
        currentPageName: name,
        currentPageArgs: args));
  }
}
