import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../routes/app_router.dart';
import '../utils/app_colors.dart';
import 'app_text.dart';

class AppLayout extends StatefulWidget {
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
    this.leadingWidth,
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
  final double? leadingWidth;

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.white,
      systemNavigationBarDividerColor: AppColors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: widget.statusBarColor,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemStatusBarContrastEnforced: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      drawer: widget.drawer,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      appBar: !widget.showAppBar && !widget.useSafeArea
          ? null
          : AppBar(
              toolbarHeight: widget.showAppBar ? null : 0,
              shadowColor: widget.appbarShadowColor ?? AppColors.transparent,
              elevation: widget.elevation,
              backgroundColor: widget.appBarColor,
              systemOverlayStyle: SystemUiOverlayStyle(
                systemNavigationBarColor: AppColors.white,
                systemNavigationBarDividerColor: AppColors.white,
                systemNavigationBarIconBrightness: Brightness.dark,
                statusBarColor: widget.statusBarColor,
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.dark,
                systemStatusBarContrastEnforced: true,
              ),
              leadingWidth: widget.leading != null ? widget.leadingWidth : null,
              leading: Builder(
                builder: (context) {
                  return widget.leading ??
                      GestureDetector(
                        onTap: () {
                          widget.onWillPop?.call().then((value) {
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
                          ].contains(widget.appBarColor)
                              ? AppColors.white
                              : AppColors.darkPurple,
                        ),
                      );
                },
              ),
              titleSpacing: 0,
              centerTitle: true,
              title: widget.titleWidget ??
                  AppText(
                    widget.title ?? "",
                    textAlign: TextAlign.center,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    maxLines: 1,
                    color: widget.titleColor ?? AppColors.white,
                  ),
              actions: widget.action,
            ),
      body: SafeArea(
        top: widget.useSafeArea,
        bottom: widget.useSafeArea,
        child: widget.child,
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
    );
  }
}
