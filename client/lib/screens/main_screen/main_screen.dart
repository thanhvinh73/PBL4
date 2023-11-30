import 'package:client/generated/translations.g.dart';
import 'package:client/screens/drawer/drawer.dart';
import 'package:client/screens/main_screen/cubit/main_screen_cubit.dart';
import 'package:client/shared/enum/main_tabs.dart';
import 'package:client/shared/helpers/dialog_helper.dart';
import 'package:client/shared/widgets/app_layout.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/widgets/app_container.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: BlocProvider(
          create: (context) => MainScreenCubit(),
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
                  action: [
                    currentTab.action(context) ?? const SizedBox.shrink()
                  ],
                  drawer: const DrawerItems(),
                  child: currentTab.widget,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
