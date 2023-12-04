import 'package:client/generated/assets.gen.dart';
import 'package:client/public_providers/app_user_cubit/app_user_cubit.dart';
import 'package:client/public_providers/page_router_cubit/page_router_cubit.dart';
import 'package:client/routes/app_router.dart';
import 'package:client/shared/helpers/banner.helper.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:client/shared/widgets/app_container.dart';
import 'package:client/shared/widgets/app_dismiss_keyboard.dart';
import 'package:client/shared/widgets/app_layout.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppUserCubit, AppUserState>(
      listenWhen: (previous, current) =>
          previous.checkInternet != current.checkInternet &&
          current.checkInternet != null,
      listener: (context, state) {
        if (state.checkInternet!) {
          final PageRouterState pageRouterState =
              context.read<PageRouterCubit>().state;
          Get.toNamed(pageRouterState.previousPageName ?? Routes.login,
              arguments: pageRouterState.previousPageArgs);
        }
      },
      child: AppDismissKeyboard(
        onWillPop: false,
        child: AppLayout(
          leading: const SizedBox.shrink(),
          showAppBar: false,
          useSafeArea: true,
          child: Center(
            child: AppContainer(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Assets.images.pcNoInternet.image(),
                      AppText(
                        "Không có kết nối mạng",
                        fontSize: 30,
                        color: AppColors.titleText,
                        fontWeight: FontWeight.bold,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      AppText(
                        "Kết nối của bạn đã bị gián đoạn\nVui lòng kiểm tra lại kết nối mạng của mình",
                        fontSize: 17,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                        color: AppColors.bodyText,
                      ),
                    ],
                  ),
                  AppButton(
                      color: AppColors.titleText,
                      title: "Kiểm tra lại",
                      onPressed: () {
                        Connectivity().checkConnectivity().then((result) {
                          if (result == ConnectivityResult.wifi) {
                            context.read<AppUserCubit>().updateState(
                                (p0) => p0.copyWith(checkInternet: true));
                          } else {
                            showInfoBanner(
                                content: "Không có kết nối internet");
                          }
                        });
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
