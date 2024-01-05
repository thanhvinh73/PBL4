import 'dart:async';

import 'package:client/shared/widgets/app_container.dart';
import 'package:flutter/material.dart';

import '../../../shared/utils/app_colors.dart';

class ArrowNavigationWidget extends StatefulWidget {
  const ArrowNavigationWidget({
    super.key,
    required this.onChangedPan,
    required this.onChangedTilt,
    this.size = 50,
  });
  final void Function(int pan) onChangedPan;
  final void Function(int tilt) onChangedTilt;
  final double size;

  @override
  State<ArrowNavigationWidget> createState() => _ArrowNavigationWidgetState();
}

class _ArrowNavigationWidgetState extends State<ArrowNavigationWidget> {
  int pan = 90;
  int tilt = 90;
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

    return asc ? pan + 5 : pan - 5;
  }

  int changeTilt(bool asc) {
    if (tilt == 0 && !asc) return 0;
    if (tilt == maxAngle && asc) return maxAngle;
    return asc ? tilt + 5 : tilt - 5;
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
                    Timer.periodic(const Duration(milliseconds: 150), (timer) {
                  setState(() {
                    tilt = changeTilt(true);
                    widget.onChangedTilt.call(tilt);
                  });
                });
              },
              onTap: () {
                setState(() {
                  tilt = changeTilt(true);
                  widget.onChangedTilt.call(tilt);
                });
              },
              child: _buildItem(icon: Icons.arrow_upward_rounded),
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
                    Timer.periodic(const Duration(milliseconds: 150), (timer) {
                  setState(() {
                    pan = changePan(false);
                    widget.onChangedPan.call(pan);
                  });
                });
              },
              onTap: () {
                setState(() {
                  pan = changePan(false);
                  widget.onChangedPan.call(pan);
                });
              },
              child: _buildItem(icon: Icons.arrow_back_rounded),
            ),
            GestureDetector(
              onLongPressEnd: (details) {
                _timerPan?.cancel();
                widget.onChangedPan.call(pan);
              },
              onLongPress: () {
                _timerPan =
                    Timer.periodic(const Duration(milliseconds: 150), (timer) {
                  setState(() {
                    pan = changePan(true);
                    widget.onChangedPan.call(pan);
                  });
                });
              },
              onTap: () {
                setState(() {
                  pan = changePan(true);
                  widget.onChangedPan.call(pan);
                });
              },
              child: _buildItem(icon: Icons.arrow_forward_rounded),
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
                    Timer.periodic(const Duration(milliseconds: 150), (timer) {
                  setState(() {
                    tilt = changeTilt(false);
                    widget.onChangedTilt.call(tilt);
                  });
                });
              },
              onTap: () {
                setState(() {
                  tilt = changeTilt(false);
                  widget.onChangedTilt.call(tilt);
                });
              },
              child: _buildItem(icon: Icons.arrow_downward_rounded),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildItem({required IconData icon}) {
    return AppContainer(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(100),
      gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColors.darkPurple,
            AppColors.primaryColor,
            AppColors.lightPurple
          ]),
      child: Icon(icon, size: widget.size, color: AppColors.white),
    );
  }
}
