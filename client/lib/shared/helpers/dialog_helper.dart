import 'package:client/generated/translations.g.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<dynamic> showErrorDialog(BuildContext context,
        {String? title, String? content}) =>
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
        Text(
          title ?? tr(LocaleKeys.Auth_Error),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          content ?? tr(LocaleKeys.Auth_Error),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.bodyText,
            fontWeight: FontWeight.w600,
            fontSize: 16,
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
        Text(
          title ?? tr(LocaleKeys.App_Confirm),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          content ?? tr(LocaleKeys.App_ActionConfirm),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.bodyText,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: AppButton(
                color: AppColors.primaryColor,
                title: tr(LocaleKeys.App_Cancel),
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
        Text(
          title ?? tr(LocaleKeys.App_Success),
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          content ?? tr(LocaleKeys.App_YourActionMakingSuccessfully),
          style: const TextStyle(
            color: AppColors.bodyText,
            fontSize: 16,
          ),
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
