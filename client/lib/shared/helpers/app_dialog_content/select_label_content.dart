import 'package:client/models/label_order/label_order.dart';
import 'package:client/shared/widgets/app_container.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../widgets/app_text.dart';

class SelectLabelContent extends StatelessWidget {
  const SelectLabelContent({
    super.key,
    required this.initLabel,
    required this.list,
  });
  final LabelOrder initLabel;
  final List<LabelOrder> list;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      padding: const EdgeInsets.all(16),
      color: AppColors.white,
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText("Lựa chọn nhãn hành động muốn thay đổi",
              color: AppColors.darkPurple,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              padding: const EdgeInsets.only(bottom: 16)),
          Wrap(
            runSpacing: 16,
            children: list
                .where((element) => element.label != initLabel.label)
                .map((e) => GestureDetector(
                      onTap: () {
                        Navigator.pop<LabelOrder>(context, e);
                      },
                      child: AppContainer(
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
                            const SizedBox(width: 8),
                            Expanded(
                                child: AppText(
                              e.label!.name.toUpperCase(),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
