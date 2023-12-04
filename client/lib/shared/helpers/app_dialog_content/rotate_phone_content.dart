import 'dart:async';

import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_dismiss_keyboard.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart' as lottie;

class RotatePhoneContentWidget extends StatefulWidget {
  const RotatePhoneContentWidget({super.key, required this.context});
  final BuildContext context;

  @override
  State<RotatePhoneContentWidget> createState() =>
      _RotatePhoneContentWidgetState();
}

class _RotatePhoneContentWidgetState extends State<RotatePhoneContentWidget> {
  late final Timer _timer;

  @override
  void initState() {
    _timer = Timer(const Duration(seconds: 5), () {
      Navigator.pop(widget.context);
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDismissKeyboard(
      onWillPop: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TapRegion(
            onTapOutside: (event) {
              Navigator.pop(widget.context);
            },
            child: lottie.Lottie.asset(
              "assets/lotties/lt_rotate_phone.json",
              repeat: true,
              animate: true,
              height: 150,
            ),
          ),
          const SizedBox(height: 8),
          AppText(
            "Vui lòng xoay ngang điện thoại",
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
}
