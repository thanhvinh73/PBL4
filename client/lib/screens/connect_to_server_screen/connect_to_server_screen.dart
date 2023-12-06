import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:client/generated/assets.gen.dart';
import 'package:client/generated/translations.g.dart';
import 'package:client/public_providers/app_user_cubit/app_user_cubit.dart';
import 'package:client/routes/app_router.dart';
import 'package:client/screens/connect_to_server_screen/cubit/connect_to_server_screen_cubit.dart';
import 'package:client/services/apis/api_client.dart';
import 'package:client/services/app_dio.dart';
import 'package:client/services/public_api.dart';
import 'package:client/shared/helpers/dialog_helper.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:client/shared/widgets/app_layout.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:client/shared/widgets/app_text_field.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ConnectToServerScreen extends StatefulWidget {
  const ConnectToServerScreen({super.key});

  @override
  State<ConnectToServerScreen> createState() => _ConnectToServerScreenState();
}

class _ConnectToServerScreenState extends State<ConnectToServerScreen>
    with AfterLayoutMixin {
  final _textController = TextEditingController();
  late final StreamSubscription<ConnectivityResult> _subscription;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.wifi:
          debugPrint("WIFI: on");
          context
              .read<AppUserCubit>()
              .updateState((p0) => p0.copyWith(checkInternet: true));
          break;
        case ConnectivityResult.none:
          debugPrint("WIFI: off");
          context
              .read<AppUserCubit>()
              .updateState((p0) => p0.copyWith(checkInternet: false));
          Get.toNamed(Routes.noInternetScreen);
          break;

        default:
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
                      PublicApi.baseUrl = state.baseUrl!;
                      PublicApi.apis =
                          APIClient(AppDio(), baseUrl: state.baseUrl!);
                      context
                          .read<ConnectToServerScreenCubit>()
                          .checkToken()
                          .then((user) {
                        if (user != null) {
                          context.read<AppUserCubit>().updateUser(user);
                          Get.toNamed(Routes.main);
                          return;
                        }
                        Get.toNamed(Routes.login);
                      });
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
                    resizeToAvoidBottomInset: true,
                    title: "Kết nối đến hệ thống".toUpperCase(),
                    leading: const SizedBox.shrink(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Wrap(
                          runSpacing: 16,
                          runAlignment: WrapAlignment.start,
                          alignment: WrapAlignment.center,
                          children: [
                            Assets.icons.pcFetchApi
                                .svg(width: MediaQuery.of(context).size.width),
                            AppText(
                              "Vì sản phẩm đang trong giai đoạn phát triển. Để có thể sử dụng các dịch vụ, vui lòng nhập địa chỉ liên kết đến máy chủ ở bên dưới.",
                              textAlign: TextAlign.justify,
                              color: AppColors.titleText,
                              fontSize: 16,
                            ),
                            AppTextField(
                              placeholder: "Nhập địa chỉ url của bạn tại đây",
                              controller: _textController,
                              initValue:
                                  "https://4rmv3lht-8080.asse.devtunnels.ms",
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
