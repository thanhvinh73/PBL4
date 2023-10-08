import 'package:client/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  const AppLayout(
      {super.key,
      this.title,
      this.titleWidget,
      this.actions,
      this.leading,
      this.safeArea = false,
      this.showAppBar = true,
      this.showLeading = true,
      this.backgroundColor = AppColors.bgColor,
      this.appBarColor = AppColors.primaryColor,
      this.bottomNavigationBar,
      this.action,
      required this.child,
      this.onBack,
      this.resizeToAvoidBottomInset});
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showAppBar;
  final Color backgroundColor;
  final Color appBarColor;
  final Widget? bottomNavigationBar;
  final Widget? action;
  final Widget child;
  final bool showLeading;
  final void Function()? onBack;
  final bool safeArea;
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        toolbarHeight: showAppBar ? null : 0,
        centerTitle: true,
        titleSpacing: 0,
        leadingWidth: showLeading ? null : 0,
        leading: showLeading
            ? leading ??
                GestureDetector(
                  onTap: onBack,
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 25,
                  ),
                )
            : const SizedBox.shrink(),
        actions: [action ?? const SizedBox.shrink()],
        title: Text(
          title ?? "",
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        color: AppColors.transparent,
        child: SafeArea(top: safeArea, bottom: safeArea, child: child),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
