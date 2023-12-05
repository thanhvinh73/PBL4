import 'package:bloc/bloc.dart';
import 'package:client/shared/enum/screen_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../repositories/auth_repository.dart';
import '../../../services/public_api.dart';
import '../../../shared/helpers/bot_toast_helper.dart';
import '../../../shared/helpers/dio_error_helper.dart';
import '../../../shared/utils/shared_preference.dart';

part 'drawer_state.dart';
part 'drawer_cubit.freezed.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(const DrawerState.initial());

  final _authRepository = AuthRepository(apis: PublicApi.apis);
  Future logout() async {
    final cancel = showLoading();
    try {
      await _authRepository.logout();
      await sp.clear();
      cancel();
      emit(state.copyWith(status: ScreenStatus.success));
    } catch (e) {
      cancel();
      emit(state.copyWith(errorMessage: parseError(e)));
    }
  }

  updateState(DrawerState Function(DrawerState) onUpdate) =>
      emit(onUpdate(state));
}
