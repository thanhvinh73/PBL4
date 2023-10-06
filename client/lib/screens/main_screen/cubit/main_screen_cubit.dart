import 'package:bloc/bloc.dart';
import 'package:client/shared/enum/bottom_tabs.dart';
import 'package:client/shared/enum/screen_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_screen_state.dart';
part 'main_screen_cubit.freezed.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(const MainScreenState());

  void resetErrorMessage() => emit(state.copyWith(errorMessage: null));
  updateState(MainScreenState Function(MainScreenState) onUpdate) =>
      emit(onUpdate(state));
}
