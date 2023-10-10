import 'package:client/public_providers/app_user_cubit/app_user_cubit.dart';
import 'package:client/routes/app_router.dart';
import 'package:client/screens/login_screen/cubit/login_screen_cubit.dart';
import 'package:client/shared/helpers/dialog_helper.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/utils/validators.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:client/shared/widgets/app_dismiss_keyboard.dart';
import 'package:client/shared/widgets/app_layout.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:client/shared/widgets/forms/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                      previous.user != current.user,
                  listener: (context, state) {
                    if (state.user != null) {
                      context.read<AppUserCubit>().updateUser(state.user);
                      Get.toNamed(Routes.main);
                    }
                  },
                ),
              ],
              child: LayoutBuilder(
                builder: (context, constraints) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Wrap(
                        runSpacing: 16,
                        children: [
                          AppTextFormField(
                              label: "Tên đăng nhập",
                              placeholder: "Nhập tên đăng nhập",
                              validations: const [Validators.validateNotEmpty],
                              onchanged: (_) {
                                context.read<LoginScreenCubit>().updateState(
                                    (p0) => p0.copyWith(username: _));
                              }),
                          AppTextFormField(
                              label: "Mật khẩu",
                              placeholder: "Nhập mật khẩu",
                              validations: const [Validators.validatePassword],
                              obscureText: true,
                              onchanged: (_) {
                                context.read<LoginScreenCubit>().updateState(
                                    (p0) => p0.copyWith(password: _));
                              }),
                          Align(
                              alignment: Alignment.centerRight,
                              child: AppText("Quên mật khẩu?")),
                          AppButton(
                            width: MediaQuery.of(context).size.width,
                            title: "Đăng nhập",
                            onPressed: () {
                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate()) {
                                context.read<LoginScreenCubit>().login();
                              }
                            },
                          ),
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
              ),
            )),
      ),
    );
  }
}
