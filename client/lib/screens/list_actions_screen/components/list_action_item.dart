import 'package:client/models/label_order/label_order.dart';
import 'package:client/screens/list_actions_screen/cubit/list_actions_screen_cubit.dart';
import 'package:client/shared/enum/label_order.dart';
import 'package:client/shared/helpers/dialog_helper.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_container.dart';
import 'package:client/shared/widgets/app_popup_menu.dart';
import 'package:client/shared/widgets/app_popup_menu_item.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ActionOption { changeOrder }

extension ActionOptionExt on ActionOption {
  String get label => {
        // ActionOption.detail: "Xem chi tiết",
        ActionOption.changeOrder: "Thay đổi lệnh hành động"
      }[this]!;
}

class ListActionItem extends StatelessWidget {
  const ListActionItem({
    super.key,
    required this.labelOrder,
  });
  final LabelOrder labelOrder;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      color: AppColors.bgPurple,
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(10),
      child: Row(
        children: [
          const Icon(
            Icons.slideshow_rounded,
            size: 25,
            color: AppColors.darkPurple,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: AppText(
            labelOrder.label!.description,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          )),
          AppPopupMenu<ActionOption>(
            items: ActionOption.values
                .map((e) => AppPopupMenuItem(label: e.label, value: e))
                .toList(),
            onSeleted: (value) {
              switch (value) {
                case ActionOption.changeOrder:
                  showSelectLabelDialog(context,
                          initLabel: labelOrder,
                          list: context
                                  .read<ListActionsScreenCubit>()
                                  .state
                                  .labelOrders ??
                              [])
                      .then((value) {
                    if (value != null) {
                      context
                          .read<ListActionsScreenCubit>()
                          .changeOrder(labelOrder, value);
                    }
                  });
                  break;
                default:
              }
            },
            child: const Icon(Icons.more_vert_rounded,
                size: 25, color: AppColors.darkPurple),
          ),
        ],
      ),
    );
  }
}
