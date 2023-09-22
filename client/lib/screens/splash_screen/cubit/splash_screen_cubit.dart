import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_screen_state.dart';
part 'splash_screen_cubit.freezed.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(const SplashScreenState());

  void updateBaseUrl(String? baseUrl) => emit(state.copyWith(baseUrl: baseUrl));
  void resetErrorMessage() => emit(state.copyWith(errorMessage: null));

  void confirmBaseUrl() {
    if (state.baseUrl != null && state.baseUrl!.contains("http://")) {
      emit(state.copyWith(isConfirmed: true));
    } else {
      emit(state.copyWith(errorMessage: "Định dạng url không chính xác"));
    }
  }
}
