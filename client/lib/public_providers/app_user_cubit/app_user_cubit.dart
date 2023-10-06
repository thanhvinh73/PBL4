import 'package:bloc/bloc.dart';
import 'package:client/models/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user_state.dart';
part 'app_user_cubit.freezed.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(const AppUserState.initial());

  updateUser(User? user) => emit(state.copyWith(user: user));
}
