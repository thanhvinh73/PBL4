import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../routes/app_router.dart';
import '../utils/app_colors.dart';
import 'app_text.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({
    super.key,
    required this.child,
    this.useSafeArea = false,
    this.title,
    this.titleWidget,
    this.showAppBar = true,
    this.elevation = 0,
    this.resizeToAvoidBottomInset = true,
    this.action,
    this.leading,
    this.backgroundColor = AppColors.white,
    this.appbarShadowColor,
    this.appBarColor = AppColors.primaryColor,
    this.statusBarColor = AppColors.white,
    this.titleColor,
    this.bottomNavigationBar,
    this.drawer,
    this.onWillPop,
    this.floatingActionButton,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerDocked,
  });
  final bool useSafeArea;
  final Widget child;
  final String? title;
  final Widget? titleWidget;
  final bool showAppBar;
  final double elevation;
  final bool resizeToAvoidBottomInset;
  final List<Widget>? action;
  final Widget? leading;
  final Color backgroundColor;
  final Color? appbarShadowColor;
  final Color appBarColor;
  final Color statusBarColor;
  final Color? titleColor;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Future<bool> Function()? onWillPop;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: drawer,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: !showAppBar && !useSafeArea
          ? null
          : AppBar(
              toolbarHeight: showAppBar ? null : 0,
              shadowColor: appbarShadowColor ?? AppColors.transparent,
              elevation: elevation,
              backgroundColor: appBarColor,
              systemOverlayStyle: SystemUiOverlayStyle(
                systemNavigationBarColor: AppColors.white,
                systemNavigationBarDividerColor: AppColors.white,
                systemNavigationBarIconBrightness: Brightness.dark,
                statusBarColor: statusBarColor,
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.dark,
                systemStatusBarContrastEnforced: true,
              ),
              leadingWidth: leading != null ? 85 : null,
              leading: Builder(
                builder: (context) {
                  return leading ??
                      GestureDetector(
                        onTap: () {
                          onWillPop?.call().then((value) {
                            if (value != false) {
                              if (Navigator.of(context).canPop()) {
                                Navigator.of(context).pop();
                              } else {
                                Navigator.of(context)
                                    .pushReplacementNamed(Routes.login);
                              }
                            }
                          });
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 23,
                          color: [
                            AppColors.darkPurple,
                            AppColors.lightPurple,
                            AppColors.primaryColor
                          ].contains(appBarColor)
                              ? AppColors.white
                              : AppColors.darkPurple,
                        ),
                      );
                },
              ),
              titleSpacing: 0,
              centerTitle: true,
              title: titleWidget ??
                  AppText(
                    title ?? "",
                    textAlign: TextAlign.center,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    maxLines: 1,
                    color: titleColor ?? AppColors.white,
                  ),
              actions: action,
            ),
      body: SafeArea(
        top: useSafeArea,
        bottom: useSafeArea,
        child: child,
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
