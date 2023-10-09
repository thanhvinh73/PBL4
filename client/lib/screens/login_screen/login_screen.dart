import 'package:client/routes/app_router.dart';
import 'package:client/screens/login_screen/cubit/login_screen_cubit.dart';
import 'package:client/shared/enum/screen_status.dart';
import 'package:client/shared/helpers/dialog_helper.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/utils/validators.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:client/shared/widgets/app_dismiss_keyboard.dart';
import 'package:client/shared/widgets/app_layout.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:client/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginScreenCubit(),
      child: AppDismissKeyboard(
        onWillPop: false,
        child: AppLayout(
            showAppBar: false,
            showLeading: false,
            resizeToAvoidBottomInset: true,
            child: MultiBlocListener(
              listeners: [
                BlocListener<LoginScreenCubit, LoginScreenState>(
                  listenWhen: (previous, current) =>
                      previous.errorMessage != current.errorMessage &&
                      current.errorMessage != null,
                  listener: (context, state) {
                    showErrorDialog(context, content: state.errorMessage)
                        .then((value) {
                      context
                          .read<LoginScreenCubit>()
                          .updateState((p0) => p0.copyWith(errorMessage: null));
                    });
                  },
                ),
                BlocListener<LoginScreenCubit, LoginScreenState>(
                  listenWhen: (previous, current) =>
                      previous.status != current.status,
                  listener: (context, state) {
                    if (state.status == ScreenStatus.success) {
                      Get.toNamed(Routes.main);
                    }
                  },
                ),
              ],
              child: LayoutBuilder(
                builder: (context, constraints) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Wrap(
                      runSpacing: 16,
                      children: [
                        BlocBuilder<LoginScreenCubit, LoginScreenState>(
                          buildWhen: (previous, current) =>
                              previous.invalidUsername !=
                              current.invalidUsername,
                          builder: (context, state) {
                            return AppTextField(
                                label: "Tên đăng nhập",
                                placeholder: "Nhập tên đăng nhập",
                                errorLabel: state.invalidUsername,
                                controller: _usernameController,
                                onChanged: (_) {
                                  context.read<LoginScreenCubit>().updateState(
                                      (p0) => p0.copyWith(
                                          username: _,
                                          invalidUsername:
                                              Validators.validateNotEmpty(_)));
                                });
                          },
                        ),
                        BlocBuilder<LoginScreenCubit, LoginScreenState>(
                          buildWhen: (previous, current) =>
                              previous.invalidPassword !=
                              current.invalidPassword,
                          builder: (context, state) {
                            return AppTextField(
                                label: "Mật khẩu",
                                placeholder: "Nhập mật khẩu",
                                errorLabel: state.invalidPassword,
                                controller: _passwordController,
                                onChanged: (_) {
                                  context.read<LoginScreenCubit>().updateState(
                                      (p0) => p0.copyWith(
                                          password: _,
                                          invalidPassword:
                                              Validators.validatePassword(_)));
                                });
                          },
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: AppText("Quên mật khẩu?")),
                        AppButton(
                            width: MediaQuery.of(context).size.width,
                            title: "Đăng nhập",
                            onPressed: context.read<LoginScreenCubit>().login),
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.register),
                          child: Align(
                              alignment: Alignment.center,
                              child: Wrap(
                                spacing: 4,
                                children: [
                                  AppText(
                                    "Bạn chưa có tài khoản?",
                                    fontSize: 15,
                                  ),
                                  AppText(
                                    "Đăng ký",
                                    color: AppColors.darkPurple,
                                    fontSize: 15,
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
