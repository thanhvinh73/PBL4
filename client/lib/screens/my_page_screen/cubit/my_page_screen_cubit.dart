import 'package:bloc/bloc.dart';
import 'package:client/repositories/auth_repository.dart';
import 'package:client/services/public_api.dart';
import 'package:client/shared/helpers/bot_toast_helper.dart';
import 'package:client/shared/helpers/dio_error_helper.dart';
import 'package:client/shared/utils/shared_preference.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_page_screen_state.dart';
part 'my_page_screen_cubit.freezed.dart';

class MyPageScreenCubit extends Cubit<MyPageScreenState> {
  MyPageScreenCubit() : super(const MyPageScreenState.initial());
  final _authRepository = AuthRepository(apis: PublicApi.apis);
  Future logout() async {
    final cancel = showLoading();
    try {
      await _authRepository.logout();
      await sp.clear();
      cancel();
      emit(state.copyWith(isLogout: true));
    } catch (e) {
      cancel();
      emit(state.copyWith(errorMessage: parseError(e)));
    }
  }

  updateState(MyPageScreenState Function(MyPageScreenState) onUpdate) =>
      emit(onUpdate(state));
}
