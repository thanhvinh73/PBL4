import 'package:client/generated/assets.gen.dart';
import 'package:client/generated/translations.g.dart';
import 'package:client/routes/app_router.dart';
import 'package:client/screens/connect_to_server_screen/cubit/connect_to_server_screen_cubit.dart';
import 'package:client/services/base_url.dart';
import 'package:client/shared/helpers/dialog_helper.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:client/shared/widgets/app_layout.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:client/shared/widgets/app_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ConnectToServerScreen extends StatelessWidget {
  ConnectToServerScreen({super.key});

  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: WillPopScope(
          onWillPop: () => Future.value(false),
          child: BlocProvider(
            create: (context) => ConnectToServerScreenCubit(),
            child: MultiBlocListener(
              listeners: [
                BlocListener<ConnectToServerScreenCubit,
                    ConnectToServerScreenState>(
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
                      Get.toNamed(Routes.login);
                    });
                  },
                ),
                BlocListener<ConnectToServerScreenCubit,
                    ConnectToServerScreenState>(
                  listenWhen: (previous, current) =>
                      previous.errorMessage != current.errorMessage &&
                      current.errorMessage != null,
                  listener: (context, state) {
                    showErrorDialog(context,
                            title: tr(LocaleKeys.Auth_Error),
                            content: state.errorMessage)
                        .then((value) => context
                            .read<ConnectToServerScreenCubit>()
                            .resetErrorMessage());
                  },
                ),
              ],
              child: BlocBuilder<ConnectToServerScreenCubit,
                  ConnectToServerScreenState>(
                builder: (context, state) {
                  return AppLayout(
                    showLeading: false,
                    resizeToAvoidBottomInset: true,
                    title: "Kết nối đến hệ thống".toUpperCase(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Wrap(
                          runSpacing: 16,
                          runAlignment: WrapAlignment.start,
                          alignment: WrapAlignment.center,
                          children: [
                            Assets.images.pcFetchApi.image(
                                width: MediaQuery.of(context).size.width * 0.8),
                            AppText(
                              "Vì sản phẩm đang trong giai đoạn phát triển. Để có thể sử dụng các dịch vụ, vui lòng nhập địa chỉ liên kết đến máy chủ ở bên dưới.",
                              textAlign: TextAlign.justify,
                              color: AppColors.titleText,
                              fontSize: 16,
                            ),
                            AppTextField(
                              placeholder: "Nhập địa chỉ url của bạn tại đây",
                              controller: _textController,
                              onChanged: context
                                  .read<ConnectToServerScreenCubit>()
                                  .updateBaseUrl,
                            ),
                            AppButton(
                                width: MediaQuery.of(context).size.width,
                                title: "Xác nhận",
                                onPressed: context
                                    .read<ConnectToServerScreenCubit>()
                                    .confirmBaseUrl)
                          ],
                        ),
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
