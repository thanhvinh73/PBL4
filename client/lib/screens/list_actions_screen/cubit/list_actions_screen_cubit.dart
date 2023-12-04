import 'package:bloc/bloc.dart';
import 'package:client/repositories/label_order_repository.dart';
import 'package:client/services/api_response/api_response.dart';
import 'package:client/services/public_api.dart';
import 'package:client/shared/enum/screen_status.dart';
import 'package:client/shared/helpers/bot_toast_helper.dart';
import 'package:client/shared/helpers/dio_error_helper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/label_order/label_order.dart';

part 'list_actions_screen_state.dart';
part 'list_actions_screen_cubit.freezed.dart';

class ListActionsScreenCubit extends Cubit<ListActionsScreenState> {
  ListActionsScreenCubit(String userId)
      : super(ListActionsScreenState.initial(userId: userId));

  final LabelRepository _labelRepository =
      LabelRepository(apis: PublicApi.apis);

  Future getLabels() async {
    final cancel = showLoading();
    try {
      ApiResponse<List<LabelOrder>> res =
          await PublicApi.apis.getLabelByUser(state.userId);

      int i = 0;
      List<LabelOrder> result = [];
      while (i < (res.data ?? []).length) {
        result.add(
            (res.data ?? []).firstWhere((element) => element.labelOrder == i));
        i++;
      }

      emit(state.copyWith(labelOrders: result));
      cancel();
    } catch (err) {
      cancel();
      emit(state.copyWith(errorMessage: parseError(err)));
    }
  }

  Future changeOrder(LabelOrder labelOrder1, LabelOrder labelOrder2) async {
    final cancel = showLoading();
    try {
      await _labelRepository.changeOrder(
          state.userId, labelOrder1.label!, labelOrder2.label!);
      emit(state.copyWith(status: ScreenStatus.success));
      cancel();
    } catch (err) {
      cancel();
      emit(state.copyWith(errorMessage: parseError(err)));
    }
  }

  updateState(
          ListActionsScreenState Function(ListActionsScreenState) onUpdate) =>
      emit(onUpdate(state));
}
