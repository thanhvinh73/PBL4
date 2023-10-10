import 'package:bloc/bloc.dart';
import 'package:client/models/credential/credential.dart';
import 'package:client/models/user/user.dart';
import 'package:client/repositories/auth_repository.dart';
import 'package:client/services/api_response/api_response.dart';
import 'package:client/services/public_api.dart';
import 'package:client/shared/enum/screen_status.dart';
import 'package:client/shared/helpers/bot_toast_helper.dart';
import 'package:client/shared/helpers/dio_error_helper.dart';
import 'package:client/shared/utils/shared_preference.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_screen_state.dart';
part 'login_screen_cubit.freezed.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit() : super(const LoginScreenState.initial());

  final _authRepository = AuthRepository(apis: PublicApi.apis);

  Future<void> login() async {
    final cancel = showLoading();
    try {
      ApiResponse<Credential> res =
          await _authRepository.login(state.username!, state.password!);
      if (res.data != null) {
        await sp.setToken(res.data!.accessToken, res.data!.refreshToken);
        await _getUser();
      }
      cancel();
    } catch (err) {
      cancel();
      emit(state.copyWith(errorMessage: parseError(err)));
    }
  }

  Future<void> _getUser() async {
    ApiResponse<User> res = await PublicApi.apis.getUser();
    if (res.data != null) {
      emit(state.copyWith(user: res.data));
    }
  }

  updateState(LoginScreenState Function(LoginScreenState) onUpdate) =>
      emit(onUpdate(state));
}
