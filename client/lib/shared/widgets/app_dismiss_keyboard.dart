import 'package:flutter/material.dart';

class AppDismissKeyboard extends StatelessWidget {
  const AppDismissKeyboard(
      {super.key, required this.child, required this.onWillPop});
  final Widget child;
  final bool onWillPop;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: WillPopScope(
        onWillPop: () => Future.value(onWillPop),
        child: onWillPop
            ? child
            : WillPopScope(
                onWillPop: () => Future.value(false),
                child: child,
              ),
      ),
    );
  }
}
