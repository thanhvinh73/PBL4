import 'package:client/generated/assets.gen.dart';
import 'package:client/generated/translations.g.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:client/shared/widgets/app_container.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum TutorialDescription { description1, description2, description3 }

extension TutorialDescriptionExt on TutorialDescription {
  SvgPicture get svgPicture => {
        TutorialDescription.description1:
            Assets.icons.pcHintCameraSelectUrl.svg(),
        TutorialDescription.description2: Assets.icons.pcHintCamera.svg(),
        TutorialDescription.description3:
            Assets.icons.pcHintCameraChangePosition.svg()
      }[this]!;

  String get buttonLabel => {
        TutorialDescription.description1:
            tr(LocaleKeys.CameraUrl_HintLabelButton1),
        TutorialDescription.description2:
            tr(LocaleKeys.CameraUrl_HintLabelButton2),
        TutorialDescription.description3:
            tr(LocaleKeys.CameraUrl_HintLabelButton3)
      }[this]!;

  String get title => {
        TutorialDescription.description1: tr(LocaleKeys.CameraUrl_HintTitle1),
        TutorialDescription.description2: tr(LocaleKeys.CameraUrl_HintTitle2),
        TutorialDescription.description3: tr(LocaleKeys.CameraUrl_HintTitle3)
      }[this]!;

  String get description => {
        TutorialDescription.description1:
            tr(LocaleKeys.CameraUrl_HintDescription1),
        TutorialDescription.description2:
            tr(LocaleKeys.CameraUrl_HintDescription2),
        TutorialDescription.description3:
            tr(LocaleKeys.CameraUrl_HintDescription3)
      }[this]!;
}

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
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
            Expanded(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                    title: TutorialDescription.values
                        .elementAt(currentIndex)
                        .buttonLabel,
                    borderRadius: 50,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    onPressed: () {
                      if (currentIndex ==
                          TutorialDescription.values.length - 1) {
                        return;
                      }
                      _pageController.animateToPage(currentIndex + 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linearToEaseOut);
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    onPressed: () {
                      if (currentIndex ==
                          TutorialDescription.values.length - 1) {
                        return;
                      }
                      _pageController.animateToPage(currentIndex + 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linearToEaseOut);
                    })
              ],
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
