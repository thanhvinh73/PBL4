import 'package:bloc/bloc.dart';
import 'package:client/shared/enum/main_tabs.dart';
import 'package:client/shared/enum/screen_status.dart';
import 'package:client/shared/utils/shared_preference.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_screen_state.dart';
part 'main_screen_cubit.freezed.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(const MainScreenState()) {
    if (!sp.isLogInBefore) {
      emit(state.copyWith(currentTab: MainTabs.tutorial));
      sp.prefs.setBool("is_log_in_before", true);
    } else {
      emit(state.copyWith(currentTab: MainTabs.home));
    }
  }

  void resetErrorMessage() => emit(state.copyWith(errorMessage: null));

  changeTab(MainTabs tab) => emit(state.copyWith(currentTab: tab));

  updateState(MainScreenState Function(MainScreenState) onUpdate) =>
      emit(onUpdate(state));
}
