import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_screen_state.dart';
part 'splash_screen_cubit.freezed.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(const SplashScreenState());

  void resetErrorMessage() => emit(state.copyWith(errorMessage: null));
  updateState(SplashScreenState Function(SplashScreenState) onUpdate) =>
      emit(onUpdate(state));
}
