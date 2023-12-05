import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:client/generated/translations.g.dart';
import 'package:client/screens/drawer/drawer.dart';
import 'package:client/screens/main_screen/cubit/main_screen_cubit.dart';
import 'package:client/shared/enum/main_tabs.dart';
import 'package:client/shared/helpers/dialog_helper.dart';
import 'package:client/shared/widgets/app_dismiss_keyboard.dart';
import 'package:client/shared/widgets/app_layout.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/widgets/app_container.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return AppDismissKeyboard(
      onWillPop: false,
      child: MultiBlocListener(
        listeners: [
          BlocListener<MainScreenCubit, MainScreenState>(
            listenWhen: (previous, current) =>
                previous.errorMessage != current.errorMessage &&
                current.errorMessage != null,
            listener: (context, state) {
              showErrorDialog(context,
                      title: tr(LocaleKeys.Auth_Error),
                      content: state.errorMessage)
                  .then((value) =>
                      context.read<MainScreenCubit>().resetErrorMessage());
            },
          ),
        ],
        child: BlocSelector<MainScreenCubit, MainScreenState, MainTabs>(
          selector: (state) => state.currentTab,
          builder: (context, currentTab) {
            return AppLayout(
              resizeToAvoidBottomInset: true,
              useSafeArea: true,
              title: context.read<MainScreenCubit>().state.currentTab.label,
              leading: Builder(builder: (context) {
                return GestureDetector(
                  onTap: Scaffold.of(context).openDrawer,
                  child: const AppContainer(
                    margin: EdgeInsets.only(left: 16),
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.menu),
                  ),
                );
              }),
              action: [currentTab.action(context) ?? const SizedBox.shrink()],
              drawer: const DrawerItems(),
              child: currentTab.widget,
            );
          },
        ),
      ),
    );
  }
}
