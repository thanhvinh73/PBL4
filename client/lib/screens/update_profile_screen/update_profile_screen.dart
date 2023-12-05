import 'package:client/public_providers/app_user_cubit/app_user_cubit.dart';
import 'package:client/screens/update_profile_screen/cubit/update_profile_screen_cubit.dart';
import 'package:client/shared/enum/screen_status.dart';
import 'package:client/shared/helpers/banner.helper.dart';
import 'package:client/shared/utils/validators.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:client/shared/widgets/app_container.dart';
import 'package:client/shared/widgets/app_dismiss_keyboard.dart';
import 'package:client/shared/widgets/app_layout.dart';
import 'package:client/shared/widgets/forms/app_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../generated/translations.g.dart';
import '../../shared/helpers/dialog_helper.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({super.key, required this.userId});
  final String userId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AppDismissKeyboard(
      onWillPop: true,
      child: BlocProvider(
        create: (context) => UpdateProfileScreenCubit(userId),
        child: MultiBlocListener(
          listeners: [
            BlocListener<UpdateProfileScreenCubit, UpdateProfileScreenState>(
              listenWhen: (previous, current) =>
                  previous.errorMessage != current.errorMessage &&
                  current.errorMessage != null,
              listener: (context, state) {
                showErrorDialog(context,
                        title: tr(LocaleKeys.Auth_Error),
                        content: state.errorMessage)
                    .then((value) {
                  context
                      .read<UpdateProfileScreenCubit>()
                      .updateState((p0) => p0.copyWith(errorMessage: null));
                });
              },
            ),
            BlocListener<UpdateProfileScreenCubit, UpdateProfileScreenState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status == ScreenStatus.success) {
                  showSuccessBanner(
                      content:
                          tr(LocaleKeys.Profile_UpdateProfileSuccessfully));
                  context.read<AppUserCubit>().updateUser(state.currentUser);
                  Get.back();
                }
              },
            ),
          ],
          child: AppLayout(
              onWillPop: () => Future.value(true),
              useSafeArea: true,
              child: BlocBuilder<UpdateProfileScreenCubit,
                  UpdateProfileScreenState>(
                builder: (context, state) {
                  return LayoutBuilder(builder: (context, constraints) {
                    return Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: AppContainer(
                          padding: const EdgeInsets.all(16),
                          constraints:
                              BoxConstraints(minHeight: constraints.maxHeight),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Wrap(
                                runSpacing: 16,
                                children: [
                                  if (state.currentUser != null)
                                    AppTextFormField(
                                        label: tr(LocaleKeys.Auth_Email),
                                        placeholder:
                                            tr(LocaleKeys.Auth_EnterEmail),
                                        initValue: state.currentUser?.email,
                                        validations: const [
                                          Validators.validateEmail
                                        ],
                                        onchanged: (_) {
                                          context
                                              .read<UpdateProfileScreenCubit>()
                                              .updateCurrentUser((p0) =>
                                                  p0.copyWith(email: _));
                                        }),
                                  if (state.currentUser != null)
                                    AppTextFormField(
                                        label: tr(LocaleKeys.Profile_Name),
                                        placeholder:
                                            tr(LocaleKeys.Profile_EnterName),
                                        initValue: state.currentUser?.name,
                                        validations: [
                                          (data) =>
                                              Validators.validateNotEmpty(data)
                                        ],
                                        onchanged: (_) {
                                          context
                                              .read<UpdateProfileScreenCubit>()
                                              .updateCurrentUser(
                                                  (p0) => p0.copyWith(name: _));
                                        })
                                ],
                              ),
                              AppButton(
                                  width: MediaQuery.of(context).size.width,
                                  title: tr(LocaleKeys.Profile_Update),
                                  onPressed: () {
                                    if (_formKey.currentState != null &&
                                        _formKey.currentState!.validate()) {
                                      context
                                          .read<UpdateProfileScreenCubit>()
                                          .updateInfo();
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
                    );
                  });
                },
              )),
        ),
      ),
    );
  }
}
