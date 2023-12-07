import 'package:bloc/bloc.dart';
import 'package:client/services/services/i_camera_position_service.dart';
import 'package:client/shared/extensions/string_ext.dart';
import 'package:client/shared/helpers/dio_error_helper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/camera_url/camera_url.dart';

part 'camera_controller_screen_state.dart';
part 'camera_controller_screen_cubit.freezed.dart';

class CameraControllerScreenCubit extends Cubit<CameraControllerScreenState> {
  CameraControllerScreenCubit(CameraUrl? cameraUrl)
      : super(const CameraControllerScreenState.initial()) {
    if ((cameraUrl ?? const CameraUrl()).url.isNotEmptyOrNull) {
      _cameraPositionService = CameraPositionService(baseUrl: cameraUrl!.url!);
    }
  }

  late final ICameraPositionService _cameraPositionService;

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

  updateState(
          CameraControllerScreenState Function(CameraControllerScreenState)
              onUpdate) =>
      emit(onUpdate(state));
}
