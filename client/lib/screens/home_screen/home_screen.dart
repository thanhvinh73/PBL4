import 'package:client/generated/assets.gen.dart';
import 'package:client/generated/translations.g.dart';
import 'package:client/models/camera_url/camera_url.dart';
import 'package:client/public_providers/app_user_cubit/app_user_cubit.dart';
import 'package:client/screens/home_screen/components/url_row_item.dart';
import 'package:client/screens/home_screen/cubit/home_screen_cubit.dart';
import 'package:client/shared/extensions/list_ext.dart';
import 'package:client/shared/helpers/dialog_helper.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_container.dart';
import 'package:client/shared/widgets/app_dismiss_keyboard.dart';
import 'package:client/shared/widgets/app_mjpeg.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../shared/widgets/app_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Debouncer _debouncer =
      Debouncer(delay: const Duration(milliseconds: 300));

  @override
  Widget build(BuildContext context) {
    return AppDismissKeyboard(
      onWillPop: false,
      child: BlocProvider(
        create: (context) => HomeScreenCubit()..search(""),
        child: MultiBlocListener(
          listeners: [
            BlocListener<HomeScreenCubit, HomeScreenState>(
              listenWhen: (previous, current) =>
                  previous.errorMessage != current.errorMessage &&
                  current.errorMessage != null,
              listener: (context, state) {
                showErrorDialog(context,
                        title: tr(LocaleKeys.Auth_Error),
                        content: state.errorMessage)
                    .then((value) =>
                        context.read<HomeScreenCubit>().resetErrorMessage());
              },
            ),
            BlocListener<HomeScreenCubit, HomeScreenState>(
              listenWhen: (previous, current) =>
                  previous.currentUrl != current.currentUrl,
              listener: (context, state) {
                context.read<AppUserCubit>().updateState(
                    (p0) => p0.copyWith(currentCameraUrl: state.currentUrl));
              },
            ),
          ],
          child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
            builder: (context, state) {
              final appUserCameraUrl =
                  context.read<AppUserCubit>().state.currentCameraUrl;
              context.read<HomeScreenCubit>().updateState(
                  (p0) => p0.copyWith(currentUrl: appUserCameraUrl));
              return LayoutBuilder(builder: (context, constrainst) {
                return RefreshIndicator(
                  onRefresh: () => context.read<HomeScreenCubit>().search(null),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: AppContainer(
                      padding: const EdgeInsets.all(16),
                      constraints:
                          BoxConstraints(minHeight: constrainst.maxHeight),
                      child: Wrap(runSpacing: 16, children: [
                        BlocSelector<HomeScreenCubit, HomeScreenState,
                            CameraUrl?>(
                          selector: (state) => state.currentUrl,
                          builder: (context, currentCameraUrl) {
                            return AppMjpeg(
                              url: currentCameraUrl?.url ??
                                  appUserCameraUrl?.url ??
                                  "",
                              width: MediaQuery.of(context).size.width,
                              showFullScreen: true,
                              height: 250,
                            );
                          },
                        ),
                        AppTextField(
                          onChanged: (_) {
                            _debouncer.call(() {
                              context.read<HomeScreenCubit>().search(_);
                            });
                          },
                          placeholder: "Nhập tên wifi",
                          suffixIcon: const AppContainer(
                            margin: EdgeInsets.only(right: 16),
                            child: Icon(
                              Icons.search,
                              color: AppColors.titleText,
                              size: 25,
                            ),
                          ),
                        ),
                        BlocSelector<HomeScreenCubit, HomeScreenState,
                            List<CameraUrl>>(
                          selector: (state) => state.cameraUrls,
                          builder: (context, cameraUrls) {
                            return Wrap(
                              runSpacing: 16,
                              children: cameraUrls.isNullOrEmpty
                                  ? [_buildEmptyListUrl(context)]
                                  : cameraUrls
                                      .map((e) => UrlRowItem(
                                            cameraUrl: e,
                                            onTap: () {
                                              context
                                                  .read<HomeScreenCubit>()
                                                  .updateState((p0) => p0
                                                      .copyWith(currentUrl: e));
                                            },
                                            onRemove: () {
                                              context
                                                  .read<HomeScreenCubit>()
                                                  .updateState((p0) =>
                                                      p0.copyWith(
                                                          currentUrl: null));
                                            },
                                            isSelected:
                                                e.id == state.currentUrl?.id,
                                            onLongPress: () {
                                              showConfirmDialog(
                                                context,
                                                title: e.url,
                                                content:
                                                    "Bạn có chắc muốn tắt trạng thái hoạt động của đường dẫn này ",
                                                onAccept: () {
                                                  context
                                                      .read<HomeScreenCubit>()
                                                      .inactiveUrl(e.id);
                                                },
                                              );
                                            },
                                          ))
                                      .toList(),
                            );
                          },
                        ),
                      ]),
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyListUrl(BuildContext context) {
    return AppContainer(
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        children: [
          Assets.icons.pcNoData
              .svg(height: 250, width: MediaQuery.of(context).size.width),
          AppText(
            "Không tìm thấy đường dẫn nào!",
            color: AppColors.darkPurple,
            fontStyle: FontStyle.italic,
          )
        ],
      ),
    );
  }
}
