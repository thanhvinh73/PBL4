import 'package:client/routes/app_router.dart';
import 'package:client/screens/splash_screen/cubit/splash_screen_cubit.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../shared/widgets/app_text_field.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: WillPopScope(
          onWillPop: () => Future.value(false),
          child: BlocProvider(
            create: (context) => SplashScreenCubit(),
            child: MultiBlocListener(
              listeners: [
                BlocListener<SplashScreenCubit, SplashScreenState>(
                  listenWhen: (previous, current) =>
                      previous.isConfirmed != current.isConfirmed &&
                      current.isConfirmed,
                  listener: (context, state) {
                    Get.toNamed(Routes.main, arguments: state.baseUrl);
                  },
                ),
                BlocListener<SplashScreenCubit, SplashScreenState>(
                  listenWhen: (previous, current) =>
                      previous.errorMessage != current.errorMessage &&
                      current.errorMessage != null,
                  listener: (context, state) {
                    showDialog(
                        context: context,
                        builder: (_) => Center(
                              child: AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text(
                                  "Lỗi",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                content: Text(
                                  state.errorMessage!,
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: AppButton(
                                        width: MediaQuery.of(_).size.width,
                                        title: "Đóng",
                                        onPressed: () {
                                          context
                                              .read<SplashScreenCubit>()
                                              .resetErrorMessage();
                                          Navigator.pop(_);
                                        }),
                                  )
                                ],
                              ),
                            ));
                  },
                ),
              ],
              child: BlocBuilder<SplashScreenCubit, SplashScreenState>(
                builder: (context, state) {
                  return Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        backgroundColor: Colors.deepPurpleAccent,
                        title: Text(
                          "Confirm your url".toUpperCase(),
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      resizeToAvoidBottomInset: false,
                      backgroundColor: Colors.white.withOpacity(0.95),
                      body: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Wrap(
                          runSpacing: 16,
                          runAlignment: WrapAlignment.start,
                          children: [
                            AppTextField(
                              placeholder: "Nhập địa chỉ url tại đây",
                              controller: _textController,
                              onChanged: (text) {
                                context
                                    .read<SplashScreenCubit>()
                                    .updateBaseUrl(text);
                              },
                            ),
                            AppButton(
                                width: MediaQuery.of(context).size.width,
                                title: "Xác nhận",
                                onPressed: () {
                                  context
                                      .read<SplashScreenCubit>()
                                      .confirmBaseUrl();
                                })
                          ],
                        ),
                      ));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
