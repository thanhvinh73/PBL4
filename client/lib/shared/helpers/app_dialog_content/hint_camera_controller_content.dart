import 'package:client/generated/assets.gen.dart';
import 'package:client/generated/translations.g.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:client/shared/widgets/app_container.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum HintCameraControllerDescription { description1, description2 }

extension HintCameraControllerDescriptionExt
    on HintCameraControllerDescription {
  Image get image => {
        HintCameraControllerDescription.description1:
            Assets.images.pcCameraControllerDes1.image(),
        HintCameraControllerDescription.description2:
            Assets.images.pcCameraControllerDes2.image(),
      }[this]!;

  String get buttonLabel => {
        HintCameraControllerDescription.description1:
            tr(LocaleKeys.CameraController_HintLabelButton1),
        HintCameraControllerDescription.description2:
            tr(LocaleKeys.CameraController_HintLabelButton2),
      }[this]!;

  String get title => {
        HintCameraControllerDescription.description1:
            tr(LocaleKeys.CameraController_HintTitle1),
        HintCameraControllerDescription.description2:
            tr(LocaleKeys.CameraController_HintTitle2),
      }[this]!;

  String get description => {
        HintCameraControllerDescription.description1:
            tr(LocaleKeys.CameraController_HintDescription1),
        HintCameraControllerDescription.description2:
            tr(LocaleKeys.CameraController_HintDescription2),
      }[this]!;
}

class HintCameraControllerContentWidget extends StatefulWidget {
  const HintCameraControllerContentWidget({super.key});

  @override
  State<HintCameraControllerContentWidget> createState() =>
      _HintCameraControllerContentWidgetState();
}

class _HintCameraControllerContentWidgetState
    extends State<HintCameraControllerContentWidget> {
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
                tr(LocaleKeys.App_Skip),
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
              children: HintCameraControllerDescription.values
                  .map((item) => _buildItem(item))
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: 8,
                children: [
                  ...HintCameraControllerDescription.values
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
                  title: HintCameraControllerDescription.values
                      .elementAt(currentIndex)
                      .buttonLabel,
                  borderRadius: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  onPressed: () {
                    if (currentIndex ==
                        HintCameraControllerDescription.values.length - 1) {
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

  Widget _buildItem(HintCameraControllerDescription item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: item.image,
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
