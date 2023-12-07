import 'package:client/generated/assets.gen.dart';
import 'package:client/generated/translations.g.dart';
import 'package:client/screens/main_screen/cubit/main_screen_cubit.dart';
import 'package:client/shared/enum/main_tabs.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:client/shared/widgets/app_container.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uuid/uuid.dart';

enum TutorialDescription { step1, step2, step3 }

extension TutorialDescriptionExt on TutorialDescription {
  SvgPicture get svgPicture => {
        TutorialDescription.step1: Assets.icons.pcTutorialStep1.svg(),
        TutorialDescription.step2: Assets.icons.pcTutorialStep2.svg(),
        TutorialDescription.step3: Assets.icons.pcTutorialStep3.svg()
      }[this]!;

  String get buttonLabel => {
        TutorialDescription.step1: tr(LocaleKeys.App_Continue),
        TutorialDescription.step2: tr(LocaleKeys.App_Continue),
        TutorialDescription.step3: tr(LocaleKeys.App_Continue)
      }[this]!;

  String get title => {
        TutorialDescription.step1: tr(LocaleKeys.Tutorial_Step1),
        TutorialDescription.step2: tr(LocaleKeys.Tutorial_Step2),
        TutorialDescription.step3: tr(LocaleKeys.Tutorial_Step3),
      }[this]!;

  String get description => {
        TutorialDescription.step1: tr(LocaleKeys.Tutorial_StepDescription1),
        TutorialDescription.step2: tr(LocaleKeys.Tutorial_StepDescription2),
        TutorialDescription.step3: tr(LocaleKeys.Tutorial_StepDescription3),
      }[this]!;
}

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final Key _key = Key(const Uuid().v4());
  late final PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AppContainer(
        padding: const EdgeInsets.all(16),
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (currentIndex == TutorialDescription.values.length - 1)
              GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(currentIndex - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linearToEaseOut);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryColor,
                        size: 23,
                      ),
                      AppText(
                        tr(LocaleKeys.App_Back),
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ],
                  )),
            Expanded(
              key: _key,
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                controller: _pageController,
                children: TutorialDescription.values
                    .map((item) => _buildItem(item))
                    .toList(),
              ),
            ),
            if (currentIndex != TutorialDescription.values.length - 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButton(
                      title: "Quay lại",
                      borderRadius: 50,
                      color: currentIndex == 0 ? AppColors.transparent : null,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      onPressed: () {
                        if (currentIndex > 0) {
                          _pageController.animateToPage(currentIndex - 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linearToEaseOut);
                        }
                      }),
                  Wrap(
                    spacing: 8,
                    children: [
                      ...TutorialDescription.values
                          .asMap()
                          .entries
                          .map((e) => CircleAvatar(
                                backgroundColor: e.key == currentIndex
                                    ? AppColors.darkPurple
                                    : AppColors.bgPurple,
                                radius: 8,
                              ))
                          .toList(),
                    ],
                  ),
                  AppButton(
                      title: TutorialDescription.values
                          .elementAt(currentIndex)
                          .buttonLabel,
                      borderRadius: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      onPressed: () {
                        if (currentIndex <
                            TutorialDescription.values.length - 1) {
                          _pageController.animateToPage(currentIndex + 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linearToEaseOut);
                        }
                      })
                ],
              )
            else
              AppButton(
                title: tr(LocaleKeys.Tutorial_GettingStarted),
                borderRadius: 50,
                onPressed: () {
                  context.read<MainScreenCubit>().changeTab(MainTabs.home);
                },
              )
          ],
        ),
      );
    });
  }

  Widget _buildItem(TutorialDescription item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: item.svgPicture,
        ),
        Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  item.title,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.titleText,
                  padding: const EdgeInsets.only(bottom: 8),
                ),
                AppText(
                  item.description,
                  fontSize: 17,
                  color: AppColors.bodyText,
                  padding: const EdgeInsets.only(bottom: 4),
                ),
              ],
            ))
      ],
    );
  }
}
