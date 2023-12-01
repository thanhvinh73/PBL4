import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:client/models/user/user.dart';
import 'package:client/services/api_response/api_response.dart';
import 'package:client/services/public_api.dart';
import 'package:client/shared/extensions/string_ext.dart';
import 'package:client/shared/helpers/bot_toast_helper.dart';
import 'package:client/shared/utils/shared_preference.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;

part 'connect_to_server_screen_state.dart';
part 'connect_to_server_screen_cubit.freezed.dart';

class ConnectToServerScreenCubit extends Cubit<ConnectToServerScreenState> {
  ConnectToServerScreenCubit()
      : super(const ConnectToServerScreenState.initial());

  void updateBaseUrl(String? baseUrl) => emit(state.copyWith(baseUrl: baseUrl));
  void resetErrorMessage() => emit(state.copyWith(errorMessage: null));

  Future confirmBaseUrl() async {
    if (state.baseUrl != null && state.baseUrl!.contains("http://") ||
        state.baseUrl != null && state.baseUrl!.contains("https://")) {
      final cancel = showLoading();
      try {
        http.Response? res = await http
            .post(Uri.parse("${state.baseUrl!}/api/auth/check-connection"))
            .timeout(
          const Duration(seconds: 30),
          onTimeout: () {
            emit(state);
            throw "Không thể kết nối đến máy chủ!";
          },
        );
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

  Future<User?> checkToken() async {
    if (sp.accessToken.isEmptyOrNull && sp.refreshToken.isEmptyOrNull) {
      return null;
    }
    final cancel = showLoading();
    try {
      ApiResponse<User> res = await PublicApi.apis.getUser();
      cancel();
      if (res.data != null) {
        return res.data;
      }
      return null;
    } catch (e) {
      cancel();
      return null;
    }
  }
}
