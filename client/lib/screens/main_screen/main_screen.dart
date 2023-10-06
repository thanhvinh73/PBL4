import 'package:client/generated/translations.g.dart';
import 'package:client/screens/my_page_screen/my_page_screen.dart';
import 'package:client/screens/home_screen/home_screen.dart';
import 'package:client/screens/main_screen/cubit/main_screen_cubit.dart';
import 'package:client/screens/setting_controller_screen/setting_controller_screen.dart';
import 'package:client/shared/enum/bottom_tabs.dart';
import 'package:client/shared/helpers/dialog_helper.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_layout.dart';
import 'package:client/shared/widgets/bottom_tab_bar_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

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
              BlocListener<MainScreenCubit, MainScreenState>(
                listenWhen: (previous, current) =>
                    previous.currentTab != current.currentTab,
                listener: (context, state) {
                  pageController.animateToPage(state.currentTab.index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.linear);
                },
              ),
            ],
            child: BlocBuilder<MainScreenCubit, MainScreenState>(
              buildWhen: (previous, current) =>
                  previous.currentTab != current.currentTab,
              builder: (context, state) {
                return AppLayout(
                  backgroundColor: AppColors.bgColor,
                  title: context.read<MainScreenCubit>().state.currentTab.label,
                  showLeading: false,
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: state.currentTab.index,
                    unselectedItemColor: AppColors.bodyText,
                    selectedItemColor: AppColors.primaryColor,
                    selectedFontSize: 12,
                    showUnselectedLabels: true,
                    type: BottomNavigationBarType.fixed,
                    landscapeLayout:
                        BottomNavigationBarLandscapeLayout.centered,
                    items: BottomTabs.values
                        .map((e) => BottomTabBarItem(
                              icon: Column(
                                children: [
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Icon(
                                    e.icon,
                                    // color: AppColors.text,
                                  ),
                                ],
                              ),
                              label: e.label,
                              activeIcon: Column(
                                children: [
                                  SizedBox(
                                    width: 32,
                                    height: 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Icon(
                                    e.icon,
                                    // color: AppColors.text,
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                    onTap: (index) => context
                        .read<MainScreenCubit>()
                        .updateState((p0) =>
                            p0.copyWith(currentTab: BottomTabs.values[index])),
                  ),
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: const [
                      HomeScreen(),
                      SettingControllerScreen(),
                      MyPageScreen()
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
