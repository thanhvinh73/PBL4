import 'package:bloc/bloc.dart';
import 'package:client/shared/enum/screen_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_screen_state.dart';
part 'profile_screen_cubit.freezed.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  ProfileScreenCubit() : super(const ProfileScreenState.initial());

  updateState(ProfileScreenState Function(ProfileScreenState) onUpdate) =>
      emit(onUpdate(state));
}
