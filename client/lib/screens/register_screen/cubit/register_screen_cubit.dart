import 'package:bloc/bloc.dart';
import 'package:client/models/user/user.dart';
import 'package:client/repositories/auth_repository.dart';
import 'package:client/services/api_response/api_response.dart';
import 'package:client/services/public_api.dart';
import 'package:client/shared/enum/screen_status.dart';
import 'package:client/shared/helpers/bot_toast_helper.dart';
import 'package:client/shared/helpers/dio_error_helper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_screen_state.dart';
part 'register_screen_cubit.freezed.dart';

class RegisterScreenCubit extends Cubit<RegisterScreenState> {
  RegisterScreenCubit() : super(const RegisterScreenState.initial());
  final _authRepository = AuthRepository(apis: PublicApi.apis);

  Future<void> register() async {
    final cancel = showLoading();
    try {
      ApiResponse<User> res = await _authRepository.register(User(
        email: state.email,
        username: state.username,
        password: state.password,
        confirmPassword: state.confirmPassword,
      ));
      if (res.data != null) {
        emit(state.copyWith(status: ScreenStatus.success));
      }
      cancel();
    } catch (err) {
      cancel();
      emit(state.copyWith(errorMessage: parseError(err)));
    }
  }

  updateState(RegisterScreenState Function(RegisterScreenState) onUpdate) =>
      emit(onUpdate(state));
}
