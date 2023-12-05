import 'package:client/generated/assets.gen.dart';
import 'package:client/generated/translations.g.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:client/shared/widgets/app_container.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum HintShowCameraDescription { description1, description2, description3 }

extension HintShowCameraDescriptionExt on HintShowCameraDescription {
  SvgPicture get svgPicture => {
        HintShowCameraDescription.description1:
            Assets.icons.pcHintCameraSelectUrl.svg(),
        HintShowCameraDescription.description2: Assets.icons.pcHintCamera.svg(),
        HintShowCameraDescription.description3:
            Assets.icons.pcHintCameraChangePosition.svg()
      }[this]!;

  String get buttonLabel => {
        HintShowCameraDescription.description1:
            tr(LocaleKeys.CameraUrl_HintLabelButton1),
        HintShowCameraDescription.description2:
            tr(LocaleKeys.CameraUrl_HintLabelButton2),
        HintShowCameraDescription.description3:
            tr(LocaleKeys.CameraUrl_HintLabelButton3)
      }[this]!;

  String get title => {
        HintShowCameraDescription.description1:
            tr(LocaleKeys.CameraUrl_HintTitle1),
        HintShowCameraDescription.description2:
            tr(LocaleKeys.CameraUrl_HintTitle2),
        HintShowCameraDescription.description3:
            tr(LocaleKeys.CameraUrl_HintTitle3)
      }[this]!;

  String get description => {
        HintShowCameraDescription.description1:
            tr(LocaleKeys.CameraUrl_HintDescription1),
        HintShowCameraDescription.description2:
            tr(LocaleKeys.CameraUrl_HintDescription2),
        HintShowCameraDescription.description3:
            tr(LocaleKeys.CameraUrl_HintDescription3)
      }[this]!;
}

class HintShowCameraContentWidget extends StatefulWidget {
  const HintShowCameraContentWidget({super.key});

  @override
  State<HintShowCameraContentWidget> createState() =>
      _HintShowCameraContentWidgetState();
}

class _HintShowCameraContentWidgetState
    extends State<HintShowCameraContentWidget> {
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
    return AppContainer(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      color: AppColors.white,
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: Navigator.of(context).pop,
              child: AppText(
                "Bỏ qua",
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
                padding: const EdgeInsets.only(bottom: 8),
              ),
            ),
          ),
          Expanded(
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              controller: _pageController,
              children: HintShowCameraDescription.values
                  .map((item) => _buildItem(item))
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: 8,
                children: HintShowCameraDescription.values
                    .asMap()
                    .entries
                    .map((e) => CircleAvatar(
                          backgroundColor: e.key == currentIndex
                              ? AppColors.darkPurple
                              : AppColors.bgPurple,
                          radius: 8,
                        ))
                    .toList(),
              ),
              AppButton(
                  title: HintShowCameraDescription.values
                      .elementAt(currentIndex)
                      .buttonLabel,
                  borderRadius: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  onPressed: () {
                    if (currentIndex ==
                        HintShowCameraDescription.values.length - 1) {
                      Navigator.pop(context);
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
  }

  Widget _buildItem(HintShowCameraDescription item) {
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
                AppText(item.description,
                    fontSize: 17, color: AppColors.bodyText),
              ],
            ))
      ],
    );
  }
}
