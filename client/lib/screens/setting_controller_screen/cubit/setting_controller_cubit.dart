import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_controller_state.dart';
part 'setting_controller_cubit.freezed.dart';

class SettingControllerCubit extends Cubit<SettingControllerState> {
  SettingControllerCubit() : super(const SettingControllerState.initial());

  updateState(
          SettingControllerState Function(SettingControllerState) onUpdate) =>
      emit(onUpdate(state));
}
