import 'package:client/generated/translations.g.dart';
import 'package:client/screens/main_screen/cubit/main_screen_cubit.dart';
import 'package:client/shared/helpers/dialog_helper.dart';
import 'package:client/shared/utils/app_layout.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/widgets/app_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.baseUrl});
  final String baseUrl;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: BlocProvider(
          create: (context) => MainScreenCubit(baseUrl: baseUrl),
          child: BlocListener<MainScreenCubit, MainScreenState>(
            listenWhen: (previous, current) =>
                previous.errorMessage != current.errorMessage &&
                current.errorMessage != null,
            listener: (context, state) {
              showErrorDialog(context,
                      title: tr(LocaleKeys.Auth_Error),
                      content: state.errorMessage)
                  .then((value) =>
                      context.read<MainScreenCubit>().resetErrorMessage());
            },
            child: AppLayout(
                title: "Slide controller demo",
                showLeading: false,
                child: BlocBuilder<MainScreenCubit, MainScreenState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        runSpacing: 16,
                        runAlignment: WrapAlignment.start,
                        children: [
                          AppButton(
                              width: MediaQuery.of(context).size.width,
                              title: "Bắt đầu trình chiếu",
                              onPressed: () {
                                context.read<MainScreenCubit>().start();
                              }),
                          AppButton(
                              width: MediaQuery.of(context).size.width,
                              title: "Kết thúc trình chiếu",
                              onPressed: () {
                                context.read<MainScreenCubit>().stop();
                              }),
                          AppButton(
                              width: MediaQuery.of(context).size.width,
                              title: "Trang trình chiếu tiếp theo",
                              onPressed: () {
                                context.read<MainScreenCubit>().next();
                              }),
                          AppButton(
                              width: MediaQuery.of(context).size.width,
                              title: "Trang trình chiếu phía trước",
                              onPressed: () {
                                context.read<MainScreenCubit>().back();
                              }),
                          BlocBuilder<MainScreenCubit, MainScreenState>(
                            buildWhen: (previous, current) =>
                                previous.text != current.text,
                            builder: (context, state) {
                              return Align(
                                alignment: Alignment.bottomCenter,
                                child: AppText(
                                  state.text,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    );
                  },
                )),
          ),
        ),
      ),
    );
  }
}
