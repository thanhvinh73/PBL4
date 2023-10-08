import 'package:client/routes/app_router.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:client/shared/widgets/app_dismiss_keyboard.dart';
import 'package:client/shared/widgets/app_layout.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:client/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppDismissKeyboard(
      onWillPop: false,
      child: AppLayout(
          showAppBar: false,
          showLeading: false,
          resizeToAvoidBottomInset: true,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Wrap(
                runSpacing: 16,
                children: [
                  AppTextField(
                      label: "Tên đăng nhập",
                      placeholder: "Nhập tên đăng nhập",
                      controller: _usernameController,
                      onChanged: (_) {}),
                  AppTextField(
                      label: "Mật khẩu",
                      placeholder: "Nhập mật khẩu",
                      controller: _passwordController,
                      onChanged: (_) {}),
                  AppTextField(
                      isRequired: false,
                      label: "Email",
                      placeholder: "Nhập email",
                      controller: _passwordController,
                      onChanged: (_) {}),
                  AppButton(
                      width: MediaQuery.of(context).size.width,
                      title: "Đăng ký",
                      onPressed: () {}),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.login),
                    child: Align(
                        alignment: Alignment.center,
                        child: Wrap(
                          spacing: 4,
                          children: [
                            AppText(
                              "Bạn đã có tài khoản?",
                              fontSize: 15,
                            ),
                            AppText(
                              "Đăng nhập",
                              color: AppColors.darkPurple,
                              fontSize: 15,
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
