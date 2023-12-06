import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:client/services/public_api.dart';
import 'package:client/shared/extensions/string_ext.dart';
import 'package:client/shared/helpers/bot_toast_helper.dart';
import 'package:client/shared/helpers/dio_error_helper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../services/services/i_camera_position_service.dart';

part 'detection_screen_state.dart';
part 'detection_screen_cubit.freezed.dart';

class DetectionScreenCubit extends Cubit<DetectionScreenState> {
  DetectionScreenCubit({
    required String url,
    required String userId,
  }) : super(DetectionScreenState.initial(userId: userId, url: url)) {
    _cameraPositionService = CameraPositionService(baseUrl: url);
  }

  late final ICameraPositionService _cameraPositionService;

  Future detect() async {
    if (state.url.isEmptyOrNull || state.userId.isEmptyOrNull) return;
    final cancel = showLoading();
    try {
      await PublicApi.apis.detect(state.userId, {"camera_url": state.url});
      cancel();
      emit(state.copyWith(waiting: true));
      int secondes = 6;
      emit(state.copyWith(second: secondes));
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (secondes == 0) {
          timer.cancel();
        }
        emit(state.copyWith(second: secondes -= 1));
      });
      emit(state.copyWith(waiting: false));
    } catch (err) {
      cancel();
      emit(state.copyWith(errorMessage: parseError(err)));
    }
  }

  Future cancelDetection() async {
    final cancel = showLoading();
    if (state.url.isEmptyOrNull || state.userId.isEmptyOrNull) return;
    try {
      await PublicApi.apis.cancelDetection();
      cancel();
    } catch (err) {
      cancel();
      emit(state.copyWith(errorMessage: parseError(err)));
    }
  }

  rotatePan() async {
    try {
      await _cameraPositionService.rotatePan(state.pan);
    } catch (err) {
      emit(state.copyWith(errorMessage: parseError(err)));
    }
  }

  rotateTilt() async {
    try {
      await _cameraPositionService.rotateTilt(state.tilt);
    } catch (err) {
      emit(state.copyWith(errorMessage: parseError(err)));
    }
  }

  changePan(bool asc) {
    if (state.pan == 0 && !asc) return;
    if (state.pan == 180 && asc) return;
    emit(state.copyWith(pan: asc ? state.pan + 1 : state.pan - 1));
  }

  changeTilt(bool asc) {
    if (state.tilt == 0 && !asc) return;
    if (state.tilt == 180 && asc) return;
    emit(state.copyWith(tilt: asc ? state.tilt + 1 : state.tilt - 1));
  }

  updateState(DetectionScreenState Function(DetectionScreenState) onUpdate) =>
      emit(onUpdate(state));
}
