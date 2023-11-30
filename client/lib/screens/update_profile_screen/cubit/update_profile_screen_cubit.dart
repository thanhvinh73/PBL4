import 'package:bloc/bloc.dart';
import 'package:client/generated/translations.g.dart';
import 'package:client/models/user/user.dart';
import 'package:client/services/api_response/api_response.dart';
import 'package:client/services/public_api.dart';
import 'package:client/shared/enum/screen_status.dart';
import 'package:client/shared/helpers/bot_toast_helper.dart';
import 'package:client/shared/helpers/dio_error_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_screen_state.dart';
part 'update_profile_screen_cubit.freezed.dart';

class UpdateProfileScreenCubit extends Cubit<UpdateProfileScreenState> {
  UpdateProfileScreenCubit(String userId)
      : super(const UpdateProfileScreenState.initial()) {
    getUser(userId);
  }

  Future getUser(String userId) async {
    final cancel = showLoading();
    try {
      ApiResponse<User> res = await PublicApi.apis.getUserById(userId);
      if (res.data == null) {
        emit(state.copyWith(errorMessage: tr(LocaleKeys.Error_ERRUSER001)));
        return;
      }
      emit(state.copyWith(currentUser: res.data!));
      cancel();
    } catch (err) {
      cancel();
      emit(state.copyWith(errorMessage: parseError(err)));
    }
  }

  Future updateInfo() async {
    if (state.currentUser == null) return;
    final cancel = showLoading();
    try {
      ApiResponse<User> res =
          await PublicApi.apis.updateInfoUser(state.currentUser!.toJson());
      emit(
          state.copyWith(currentUser: res.data!, status: ScreenStatus.success));
      cancel();
    } catch (err) {
      cancel();
      emit(state.copyWith(errorMessage: parseError(err)));
    }
  }

  updateCurrentUser(User Function(User) onUpdate) => emit(
      state.copyWith(currentUser: onUpdate(state.currentUser ?? const User())));

  updateState(
          UpdateProfileScreenState Function(UpdateProfileScreenState)
              onUpdate) =>
      emit(onUpdate(state));
}
