import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:client/services/slide_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_screen_state.dart';
part 'main_screen_cubit.freezed.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  String baseUrl;
  MainScreenCubit({required this.baseUrl})
      : super(MainScreenState(baseUrl: baseUrl));

  late final ISlideService _slideService = SlideService(baseUrl: baseUrl);

  void next() async {
    try {
      await _slideService.next().timeout(const Duration(seconds: 5));
    } on TimeoutException {
      emit(state.copyWith(errorMessage: "Dường như đã có lỗi xảy ra"));
    }
  }

  void back() async {
    try {
      await _slideService.back().timeout(const Duration(seconds: 5));
    } on TimeoutException {
      emit(state.copyWith(errorMessage: "Dường như đã có lỗi xảy ra"));
    }
  }

  void start() async {
    try {
      await _slideService.start().timeout(const Duration(seconds: 5));
    } on TimeoutException {
      emit(state.copyWith(errorMessage: "Dường như đã có lỗi xảy ra"));
    }
  }

  void stop() async {
    try {
      await _slideService.stop().timeout(const Duration(seconds: 5));
    } on TimeoutException {
      emit(state.copyWith(errorMessage: "Dường như đã có lỗi xảy ra"));
    }
  }

  void resetErrorMessage() => emit(state.copyWith(errorMessage: null));
}
