import 'package:client/generated/translations.g.dart';
import 'package:client/models/label_order/label_order.dart';
import 'package:client/shared/helpers/app_dialog_content/hint_camera_controller_content.dart';
import 'package:client/shared/helpers/app_dialog_content/hint_label_action_content.dart';
import 'package:client/shared/helpers/app_dialog_content/hint_show_camera_content.dart';
import 'package:client/shared/helpers/app_dialog_content/rotate_phone_content.dart';
import 'package:client/shared/helpers/app_dialog_content/select_label_content.dart';
import 'package:client/shared/helpers/app_dialog_content/waiting_content.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<LabelOrder?> showWaitingDialog(BuildContext context,
    {required int seconds}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Center(child: WaitingContentWidget(seconds: seconds));
    },
  );
}

Future<LabelOrder?> showSelectLabelDialog(
  BuildContext context, {
  required LabelOrder initLabel,
  required List<LabelOrder> list,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Center(
          child: SelectLabelContent(initLabel: initLabel, list: list));
    },
  );
}

Future showRotatePhoneDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Material(
      color: AppColors.gray.withOpacity(0.1),
      child: Center(
        child: RotatePhoneContentWidget(context: _),
      ),
    ),
  );
}

Future showHintLiveCameraDialog(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const Material(
        color: AppColors.transparent,
        child: Center(
          child: HintShowCameraContentWidget(),
        ),
      ),
    );

Future showHintCameraControllerDialog(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const Material(
        color: AppColors.transparent,
        child: Center(
          child: HintCameraControllerContentWidget(),
        ),
      ),
    );

Future showHintLabelActionDialog(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const Material(
        color: AppColors.transparent,
        child: Center(
          child: HintLabelActionContentWidget(),
        ),
      ),
    );

Future<dynamic> showErrorDialog(
  BuildContext context, {
  String? title,
  String? content,
}) =>
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: ErrorDialogWidget(title: title, content: content),
          ),
        );
      },
    );

class ErrorDialogWidget extends StatelessWidget {
  final String? title;
  final String? content;
  const ErrorDialogWidget({super.key, this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(
          Icons.error,
          color: Colors.red,
          size: 55,
        ),
        const SizedBox(height: 8),
        Text(
          title ?? tr(LocaleKeys.Auth_Error),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w600,
            fontSize: 21,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content ?? tr(LocaleKeys.Auth_Error),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.bodyText,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        AppButton(
          color: AppColors.primaryColor,
          title: tr(LocaleKeys.App_Close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ]),
    );
  }
}

Future<bool?> showConfirmDialog(BuildContext context,
        {String? title,
        String? content,
        Function? onAccept,
        Function? onReject}) =>
    showDialog<bool>(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Center(
              child: ConfirmDialogWidget(
            content: content,
            title: title,
            onAccept: onAccept,
            onReject: onReject,
          )),
        );
      },
    );

class ConfirmDialogWidget extends StatelessWidget {
  final String? title;
  final String? content;
  final Function? onAccept;
  final Function? onReject;
  const ConfirmDialogWidget(
      {super.key, this.title, this.content, this.onAccept, this.onReject});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(
          Icons.check_circle_outline_outlined,
          color: Colors.green,
          size: 55,
        ),
        const SizedBox(height: 8),
        Text(
          title ?? tr(LocaleKeys.App_Confirm),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
            fontSize: 21,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content ?? tr(LocaleKeys.App_ActionConfirm),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.bodyText,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: AppButton(
                color: AppColors.white,
                borderColor: AppColors.primaryColor,
                title: tr(LocaleKeys.App_Cancel),
                titleColor: AppColors.primaryColor,
                onPressed: () {
                  Navigator.of(context).pop(false);
                  onReject?.call();
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppButton(
                color: AppColors.primaryColor,
                title: tr(LocaleKeys.App_Ok),
                onPressed: () {
                  Navigator.of(context).pop(true);
                  onAccept?.call();
                },
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

Future<dynamic> showSuccessDialog(BuildContext context,
        {String? title, String? content}) =>
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Center(
              child: SuccessDialogWidget(
            title: title,
            content: content,
          )),
        );
      },
    );

class SuccessDialogWidget extends StatelessWidget {
  final String? title;
  final String? content;
  const SuccessDialogWidget({super.key, this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(
          Icons.check_circle_sharp,
          color: Colors.green,
          size: 55,
        ),
        const SizedBox(height: 8),
        Text(
          title ?? tr(LocaleKeys.App_Success),
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
            fontSize: 21,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          content ?? tr(LocaleKeys.App_YourActionMakingSuccessfully),
          style: const TextStyle(
              color: AppColors.bodyText,
              fontSize: 18,
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        AppButton(
          color: AppColors.primaryColor,
          title: tr(LocaleKeys.App_Ok),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ]),
    );
  }
}

Future<dynamic> showInfoDialog(BuildContext context,
        {String? title, String? content}) =>
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Center(
              child: ShowInfoWidget(
            title: title,
            content: content,
          )),
        );
      },
    );

class ShowInfoWidget extends StatelessWidget {
  final String? title;
  final String? content;
  const ShowInfoWidget({super.key, this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(
          Icons.warning_amber_rounded,
          color: Colors.deepOrange,
          size: 55,
        ),
        const SizedBox(height: 8),
        Text(
          title ?? tr(LocaleKeys.App_Success),
          style: const TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.w600,
            fontSize: 21,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          content ?? tr(LocaleKeys.App_YourActionMakingSuccessfully),
          style: const TextStyle(
              color: AppColors.bodyText,
              fontSize: 18,
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        AppButton(
          color: AppColors.primaryColor,
          title: tr(LocaleKeys.App_Ok),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ]),
    );
  }
}
