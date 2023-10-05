import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:client/generated/translations.g.dart';
import 'package:client/services/slide_service.dart';
import 'package:client/shared/helpers/bot_toast_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;

part 'main_screen_state.dart';
part 'main_screen_cubit.freezed.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  String baseUrl;
  MainScreenCubit({required this.baseUrl})
      : super(MainScreenState(baseUrl: baseUrl));

  late final ISlideService _slideService = SlideService(baseUrl: baseUrl);

  void next() async {
    final cancel = showLoading();
    try {
      http.Response res =
          await _slideService.next().timeout(const Duration(seconds: 5));
      if (jsonDecode(res.body)['status'] == 200) {
        emit(state.copyWith(text: "Frontward slide"));
      }
      cancel();
    } on TimeoutException {
      cancel();

      emit(state.copyWith(errorMessage: tr(LocaleKeys.Error_TimeoutException)));
    } catch (e) {
      cancel();

      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void back() async {
    final cancel = showLoading();
    try {
      http.Response res =
          await _slideService.back().timeout(const Duration(seconds: 5));
      if (jsonDecode(res.body)['status'] == 200) {
        emit(state.copyWith(text: "Backward slide"));
      }
      cancel();
    } on TimeoutException {
      cancel();

      emit(state.copyWith(errorMessage: tr(LocaleKeys.Error_TimeoutException)));
    } catch (e) {
      cancel();

      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void start() async {
    final cancel = showLoading();
    try {
      http.Response res =
          await _slideService.start().timeout(const Duration(seconds: 5));
      if (jsonDecode(res.body)['status'] == 200) {
        emit(state.copyWith(text: "Start slide"));
      }
      cancel();
    } on TimeoutException {
      cancel();

      emit(state.copyWith(errorMessage: tr(LocaleKeys.Error_TimeoutException)));
    } catch (e) {
      cancel();

      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void stop() async {
    final cancel = showLoading();
    try {
      http.Response res =
          await _slideService.stop().timeout(const Duration(seconds: 5));
      if (jsonDecode(res.body)['status'] == 200) {
        emit(state.copyWith(text: "Stop slide"));
      }
      cancel();
    } on TimeoutException {
      cancel();

      emit(state.copyWith(errorMessage: tr(LocaleKeys.Error_TimeoutException)));
    } catch (e) {
      cancel();

      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void resetErrorMessage() => emit(state.copyWith(errorMessage: null));
  updateState(MainScreenState Function(MainScreenState) onUpdate) =>
      emit(onUpdate(state));
}
