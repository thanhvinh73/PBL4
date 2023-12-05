import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:client/services/api_response/api_response.dart';
import 'package:client/services/public_api.dart';
import 'package:client/shared/enum/screen_status.dart';
import 'package:client/shared/extensions/list_ext.dart';
import 'package:client/shared/extensions/string_ext.dart';
import 'package:client/shared/helpers/bot_toast_helper.dart';
import 'package:client/shared/helpers/dio_error_helper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/camera_url/camera_url.dart';

part 'home_screen_state.dart';
part 'home_screen_cubit.freezed.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(const HomeScreenState.initial());

  Future search(String? ssid) async {
    try {
      ApiResponse<List<CameraUrl>> res = ssid.isNotEmptyOrNull
          ? await PublicApi.apis.searchCameraUrl(ssid: ssid)
          : await PublicApi.apis.getAllActiveCameraUrl();
      emit(state.copyWith(cameraUrls: res.data ?? []));
    } catch (err) {
      emit(state.copyWith(errorMessage: parseError(err)));
    }
  }

  Future inactiveUrl(String? cameraUrlId) async {
    if (cameraUrlId.isEmptyOrNull) return;
    final cancel = showLoading();
    try {
      ApiResponse<CameraUrl> res =
          await PublicApi.apis.inactiveCameraUrl(cameraUrlId!);
      if (res.data != null) {
        emit(state.copyWith(
            status: ScreenStatus.success,
            currentUrl: null,
            cameraUrls: [...state.cameraUrls].deleteAt(
                  null,
                  condition: (p0) => p0.id == cameraUrlId,
                ) ??
                []));
      }
      cancel();
    } catch (err) {
      cancel();
      emit(state.copyWith(errorMessage: parseError(err)));
    }
  }

  // late final ISlideService _slideService =
  //     SlideService(baseUrl: PublicApi.baseUrl);

  // void next() async {
  //   final cancel = showLoading();
  //   try {
  //     http.Response res =
  //         await _slideService.next().timeout(const Duration(seconds: 5));
  //     if (jsonDecode(res.body)['status'] == 200) {
  //       emit(state.copyWith(text: "Frontward slide"));
  //     }
  //     cancel();
  //   } on TimeoutException {
  //     cancel();

  //     emit(state.copyWith(errorMessage: tr(LocaleKeys.Error_TimeoutException)));
  //   } catch (e) {
  //     cancel();

  //     emit(state.copyWith(errorMessage: e.toString()));
  //   }
  // }

  // void back() async {
  //   final cancel = showLoading();
  //   try {
  //     http.Response res =
  //         await _slideService.back().timeout(const Duration(seconds: 5));
  //     if (jsonDecode(res.body)['status'] == 200) {
  //       emit(state.copyWith(text: "Backward slide"));
  //     }
  //     cancel();
  //   } on TimeoutException {
  //     cancel();

  //     emit(state.copyWith(errorMessage: tr(LocaleKeys.Error_TimeoutException)));
  //   } catch (e) {
  //     cancel();

  //     emit(state.copyWith(errorMessage: e.toString()));
  //   }
  // }

  // void start() async {
  //   final cancel = showLoading();
  //   try {
  //     http.Response res =
  //         await _slideService.start().timeout(const Duration(seconds: 5));
  //     if (jsonDecode(res.body)['status'] == 200) {
  //       emit(state.copyWith(text: "Start slide"));
  //     }
  //     cancel();
  //   } on TimeoutException {
  //     cancel();

  //     emit(state.copyWith(errorMessage: tr(LocaleKeys.Error_TimeoutException)));
  //   } catch (e) {
  //     cancel();

  //     emit(state.copyWith(errorMessage: e.toString()));
  //   }
  // }

  // void stop() async {
  //   final cancel = showLoading();
  //   try {
  //     http.Response res =
  //         await _slideService.stop().timeout(const Duration(seconds: 5));
  //     if (jsonDecode(res.body)['status'] == 200) {
  //       emit(state.copyWith(text: "Stop slide"));
  //     }
  //     cancel();
  //   } on TimeoutException {
  //     cancel();

  //     emit(state.copyWith(errorMessage: tr(LocaleKeys.Error_TimeoutException)));
  //   } catch (e) {
  //     cancel();

  //     emit(state.copyWith(errorMessage: e.toString()));
  //   }
  // }

  void resetErrorMessage() => emit(state.copyWith(errorMessage: null));
  updateState(HomeScreenState Function(HomeScreenState) onUpdate) =>
      emit(onUpdate(state));
}
