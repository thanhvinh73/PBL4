import 'dart:async';

import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_container.dart';

class WaitingContentWidget extends StatefulWidget {
  const WaitingContentWidget({
    super.key,
    required this.seconds,
  });
  final int seconds;

  @override
  State<WaitingContentWidget> createState() => _WaitingContentWidgetState();
}

class _WaitingContentWidgetState extends State<WaitingContentWidget> {
  late int seconds;
  late Timer _timer;
  @override
  void initState() {
    seconds = widget.seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds -= 1;
      });
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
    if (seconds <= 0) Navigator.pop(context);
    return Material(
      color: AppColors.transparent,
      child: Center(
        child: AppContainer(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                "Bạn vui lòng chờ trong lúc hệ thống đang xử lý",
                textAlign: TextAlign.center,
                fontSize: 20,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 8),
              AppText(
                "$seconds giây",
                textAlign: TextAlign.center,
                fontSize: 20,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
