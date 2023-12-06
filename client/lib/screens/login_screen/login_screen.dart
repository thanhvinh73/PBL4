import 'package:client/public_providers/app_user_cubit/app_user_cubit.dart';
import 'package:client/routes/app_router.dart';
import 'package:client/screens/login_screen/cubit/login_screen_cubit.dart';
import 'package:client/shared/helpers/dialog_helper.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/utils/validators.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:client/shared/widgets/app_container.dart';
import 'package:client/shared/widgets/app_dismiss_keyboard.dart';
import 'package:client/shared/widgets/app_layout.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:client/shared/widgets/forms/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginScreenCubit(),
      child: AppDismissKeyboard(
        onWillPop: false,
        child: AppLayout(
          showAppBar: false,
          statusBarColor: AppColors.primaryColor,
          child: Scaffold(
              backgroundColor: AppColors.primaryColor,
              appBar: AppBar(
                toolbarHeight: 70,
                elevation: 0,
                leading: const SizedBox.shrink(),
                backgroundColor: AppColors.primaryColor,
                shadowColor: AppColors.transparent,
              ),
              resizeToAvoidBottomInset: true,
              body: MultiBlocListener(
                listeners: [
                  BlocListener<LoginScreenCubit, LoginScreenState>(
                    listenWhen: (previous, current) =>
                        previous.errorMessage != current.errorMessage &&
                        current.errorMessage != null,
                    listener: (context, state) {
                      showErrorDialog(context, content: state.errorMessage)
                          .then((value) {
                        context.read<LoginScreenCubit>().updateState(
                            (p0) => p0.copyWith(errorMessage: null));
                      });
                    },
                  ),
                  BlocListener<LoginScreenCubit, LoginScreenState>(
                    listenWhen: (previous, current) =>
                        previous.user != current.user,
                    listener: (context, state) {
                      if (state.user != null) {
                        context.read<AppUserCubit>().updateUser(state.user);
                        Get.toNamed(Routes.main);
                      }
                    },
                  ),
                ],
                child: SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) => SingleChildScrollView(
                      child: Column(
                        children: [
                          AppContainer(
                            padding: const EdgeInsets.all(16),
                            color: AppColors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(22),
                                topRight: Radius.circular(22)),
                            constraints: BoxConstraints(
                                minHeight: constraints.maxHeight),
                            child: Form(
                              key: _formKey,
                              child: Wrap(
                                runSpacing: 18,
                                alignment: WrapAlignment.center,
                                children: [
                                  AppText(
                                    tr(LocaleKeys.Auth_Login),
                                    fontSize: 35,
                                    color: AppColors.darkPurple,
                                    fontWeight: FontWeight.bold,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 22),
                                  ),
                                  AppTextFormField(
                                      label: tr(LocaleKeys.Auth_Username),
                                      placeholder:
                                          tr(LocaleKeys.Auth_EnterUsername),
                                      validations: const [
                                        Validators.validateNotEmpty
                                      ],
                                      initValue: "vinh2",
                                      onchanged: (_) {
                                        context
                                            .read<LoginScreenCubit>()
                                            .updateState((p0) =>
                                                p0.copyWith(username: _));
                                      }),
                                  AppTextFormField(
                                      label: tr(LocaleKeys.Auth_Password),
                                      placeholder:
                                          tr(LocaleKeys.Auth_EnterPassword),
                                      validations: const [
                                        Validators.validatePassword
                                      ],
                                      initValue: "password@1A",
                                      obscureText: true,
                                      onchanged: (_) {
                                        context
                                            .read<LoginScreenCubit>()
                                            .updateState((p0) =>
                                                p0.copyWith(password: _));
                                      }),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: AppText(
                                          tr(LocaleKeys.Auth_ForgotPassword),
                                          fontSize: 15)),
                                  AppButton(
                                    width: MediaQuery.of(context).size.width,
                                    title: tr(LocaleKeys.Auth_Login),
                                    onPressed: () {
                                      if (_formKey.currentState != null &&
                                          _formKey.currentState!.validate()) {
                                        context
                                            .read<LoginScreenCubit>()
                                            .login();
                                      }
                                    },
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          AppText(
                                            tr(LocaleKeys
                                                .Auth_DoYouNotHaveAccount),
                                            fontSize: 15,
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                Get.toNamed(Routes.register),
                                            child: AppText(
                                              tr(LocaleKeys.Auth_Register),
                                              color: AppColors.darkPurple,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
