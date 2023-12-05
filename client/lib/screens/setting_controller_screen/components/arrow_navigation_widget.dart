import 'dart:async';

import 'package:flutter/material.dart';

import '../../../shared/utils/app_colors.dart';
import '../../../shared/widgets/app_button.dart';

class ArrowNavigationWidget extends StatefulWidget {
  const ArrowNavigationWidget({
    super.key,
    required this.onChangedPan,
    required this.onChangedTilt,
    this.size = 40,
  });
  final void Function(int pan) onChangedPan;
  final void Function(int tilt) onChangedTilt;
  final double size;

  @override
  State<ArrowNavigationWidget> createState() => _ArrowNavigationWidgetState();
}

class _ArrowNavigationWidgetState extends State<ArrowNavigationWidget> {
  int pan = 0;
  int tilt = 0;
  int maxAngle = 180;
  Timer? _timerPan;
  Timer? _timerTilt;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timerPan?.cancel();
    _timerTilt?.cancel();
    super.dispose();
  }

  int changePan(bool asc) {
    if (pan == 0 && !asc) return 0;
    if (pan == maxAngle && asc) return maxAngle;

    return asc ? pan + 2 : pan - 2;
  }

  int changeTilt(bool asc) {
    if (tilt == 0 && !asc) return 0;
    if (tilt == maxAngle && asc) return maxAngle;
    return asc ? tilt + 2 : tilt - 2;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 16,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onLongPressEnd: (details) {
                _timerTilt?.cancel();
                widget.onChangedTilt.call(tilt);
              },
              onLongPress: () {
                _timerTilt =
                    Timer.periodic(const Duration(milliseconds: 50), (timer) {
                  setState(() {
                    tilt = changeTilt(true);
                    widget.onChangedTilt.call(tilt);
                  });
                });
              },
              child: AppButton(
                onPressed: () {
                  setState(() {
                    tilt = changeTilt(true);
                    widget.onChangedTilt.call(tilt);
                  });
                },
                borderRadius: 50,
                child: Icon(
                  Icons.arrow_upward_rounded,
                  color: AppColors.white,
                  size: widget.size,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onLongPressEnd: (details) {
                _timerPan?.cancel();
                widget.onChangedPan.call(pan);
              },
              onLongPress: () {
                _timerPan =
                    Timer.periodic(const Duration(milliseconds: 50), (timer) {
                  setState(() {
                    pan = changePan(false);
                    widget.onChangedPan.call(pan);
                  });
                });
              },
              child: AppButton(
                borderRadius: 50,
                onPressed: () {
                  setState(() {
                    pan = changePan(false);
                    widget.onChangedPan.call(pan);
                  });
                },
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.white,
                  size: widget.size,
                ),
              ),
            ),
            GestureDetector(
              onLongPressEnd: (details) {
                _timerPan?.cancel();
                widget.onChangedPan.call(pan);
              },
              onLongPress: () {
                _timerPan =
                    Timer.periodic(const Duration(milliseconds: 50), (timer) {
                  setState(() {
                    pan = changePan(true);
                    widget.onChangedPan.call(pan);
                  });
                });
              },
              child: AppButton(
                onPressed: () {
                  setState(() {
                    pan = changePan(true);
                    widget.onChangedPan.call(pan);
                  });
                },
                borderRadius: 50,
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.white,
                  size: widget.size,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onLongPressEnd: (details) {
                _timerTilt?.cancel();
                widget.onChangedTilt.call(tilt);
              },
              onLongPress: () {
                _timerTilt =
                    Timer.periodic(const Duration(milliseconds: 50), (timer) {
                  setState(() {
                    tilt = changeTilt(false);
                    widget.onChangedTilt.call(tilt);
                  });
                });
              },
              child: AppButton(
                onPressed: () {
                  setState(() {
                    tilt = changeTilt(false);
                    widget.onChangedTilt.call(tilt);
                  });
                },
                borderRadius: 50,
                child: Icon(
                  Icons.arrow_downward_rounded,
                  color: AppColors.white,
                  size: widget.size,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
