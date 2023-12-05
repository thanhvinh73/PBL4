import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_controller_screen_state.dart';
part 'setting_controller_screen_cubit.freezed.dart';

class SettingControllerScreenCubit extends Cubit<SettingControllerScreenState> {
  SettingControllerScreenCubit()
      : super(const SettingControllerScreenState.initial());

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
          SettingControllerScreenState Function(SettingControllerScreenState)
              onUpdate) =>
      emit(onUpdate(state));
}
