import 'package:client/generated/translations.g.dart';
import 'package:client/screens/home_screen/cubit/home_screen_cubit.dart';
import 'package:client/shared/helpers/dialog_helper.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:client/shared/widgets/app_dismiss_keyboard.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDismissKeyboard(
      onWillPop: false,
      child: BlocProvider(
        create: (context) => HomeScreenCubit(),
        child: BlocListener<HomeScreenCubit, HomeScreenState>(
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
          // child: LayoutBuilder(
          //   builder: (context, constraints) => Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: Wrap(
          //       runSpacing: 16,
          //       runAlignment: WrapAlignment.start,
          //       children: [
          //         AppButton(
          //             width: MediaQuery.of(context).size.width,
          //             title: "Bắt đầu trình chiếu",
          //             onPressed: () {
          //               context.read<HomeScreenCubit>().start();
          //             }),
          //         AppButton(
          //             width: MediaQuery.of(context).size.width,
          //             title: "Kết thúc trình chiếu",
          //             onPressed: () {
          //               context.read<HomeScreenCubit>().stop();
          //             }),
          //         AppButton(
          //             width: MediaQuery.of(context).size.width,
          //             title: "Trang trình chiếu tiếp theo",
          //             onPressed: () {
          //               context.read<HomeScreenCubit>().next();
          //             }),
          //         AppButton(
          //             width: MediaQuery.of(context).size.width,
          //             title: "Trang trình chiếu phía trước",
          //             onPressed: () {
          //               context.read<HomeScreenCubit>().back();
          //             }),
          //         BlocBuilder<HomeScreenCubit, HomeScreenState>(
          //           buildWhen: (previous, current) =>
          //               previous.text != current.text,
          //           builder: (context, state) {
          //             return Align(
          //               alignment: Alignment.bottomCenter,
          //               child: AppText(
          //                 state.text,
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w600,
          //               ),
          //             );
          //           },
          //         )
          //       ],
          //     ),
          //   ),
          // ),

          child: Center(
              child: Mjpeg(
            stream: "http://192.168.1.126:81/stream",
            isLive: true,
            error: (context, error, stack) {
              print(error);
              print(stack);
              return Text(error.toString(),
                  style: TextStyle(color: Colors.red));
            },
          )),
        ),
      ),
    );
  }
}
