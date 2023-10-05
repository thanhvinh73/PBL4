import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:client/shared/helpers/bot_toast_helper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;

part 'splash_screen_state.dart';
part 'splash_screen_cubit.freezed.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(const SplashScreenState());

  void updateBaseUrl(String? baseUrl) => emit(state.copyWith(baseUrl: baseUrl));
  void resetErrorMessage() => emit(state.copyWith(errorMessage: null));

  void confirmBaseUrl() async {
    if (state.baseUrl != null && state.baseUrl!.contains("http://") ||
        state.baseUrl != null && state.baseUrl!.contains("https://")) {
      final cancel = showLoading();
      try {
        http.Response res = await http
            .get(Uri.parse("${state.baseUrl!}/api/auth/check-connection"));
        Map<String, dynamic> data = jsonDecode(res.body);
        emit(state.copyWith(isConfirmed: data['status'] == 200));
        cancel();
      } catch (e) {
        cancel();
        emit(state.copyWith(errorMessage: e.toString(), isConfirmed: false));
      }
    } else {
      emit(state.copyWith(errorMessage: "Định dạng url không chính xác"));
    }
  }
}
