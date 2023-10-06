import 'package:client/generated/translations.g.dart';
import 'package:client/routes/app_router.dart';
import 'package:client/screens/splash_screen/cubit/splash_screen_cubit.dart';
import 'package:client/services/base_url.dart';
import 'package:client/shared/helpers/dialog_helper.dart';
import 'package:client/shared/widgets/app_layout.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../shared/widgets/app_text_field.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: WillPopScope(
          onWillPop: () => Future.value(false),
          child: BlocProvider(
            create: (context) => SplashScreenCubit(),
            child: MultiBlocListener(
              listeners: [
                BlocListener<SplashScreenCubit, SplashScreenState>(
                  listenWhen: (previous, current) =>
                      previous.isConfirmed != current.isConfirmed &&
                      current.isConfirmed,
                  listener: (context, state) {
                    showSuccessDialog(context,
                            title: tr(LocaleKeys.App_Success),
                            content:
                                tr(LocaleKeys.Auth_ConnectToServerSuccessfully))
                        .then((value) {
                      BaseUrl.baseUrl = state.baseUrl!;
                      Get.toNamed(Routes.main);
                    });
                  },
                ),
                BlocListener<SplashScreenCubit, SplashScreenState>(
                  listenWhen: (previous, current) =>
                      previous.errorMessage != current.errorMessage &&
                      current.errorMessage != null,
                  listener: (context, state) {
                    showErrorDialog(context,
                            title: tr(LocaleKeys.Auth_Error),
                            content: state.errorMessage)
                        .then((value) => context
                            .read<SplashScreenCubit>()
                            .resetErrorMessage());
                  },
                ),
              ],
              child: BlocBuilder<SplashScreenCubit, SplashScreenState>(
                builder: (context, state) {
                  return AppLayout(
                    showLeading: false,
                    title: "Kết nối đến hệ thống".toUpperCase(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        runSpacing: 16,
                        runAlignment: WrapAlignment.start,
                        children: [
                          AppTextField(
                            placeholder: "Nhập địa chỉ url của bạn tại đây",
                            controller: _textController,
                            onChanged: (text) {
                              context
                                  .read<SplashScreenCubit>()
                                  .updateBaseUrl(text);
                            },
                          ),
                          AppButton(
                              width: MediaQuery.of(context).size.width,
                              title: "Xác nhận",
                              onPressed: () {
                                context
                                    .read<SplashScreenCubit>()
                                    .confirmBaseUrl();
                              })
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
