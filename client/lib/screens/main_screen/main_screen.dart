import 'package:client/routes/app_router.dart';
import 'package:client/screens/main_screen/cubit/main_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../shared/widgets/app_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.baseUrl});
  final String baseUrl;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: WillPopScope(
        onWillPop: () => Future.value(true),
        child: BlocProvider(
          create: (context) => MainScreenCubit(baseUrl: baseUrl),
          child: BlocListener<MainScreenCubit, MainScreenState>(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: AppButton(
                                  width: MediaQuery.of(_).size.width,
                                  title: "Đóng",
                                  onPressed: () {
                                    context
                                        .read<MainScreenCubit>()
                                        .resetErrorMessage();
                                    Navigator.pop(_);
                                  }),
                            )
                          ],
                        ),
                      ));
            },
            child: Scaffold(
              backgroundColor: Colors.white.withOpacity(0.95),
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.splash);
                  },
                  child: const Icon(
                    Icons.chevron_left,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.deepPurpleAccent,
                title: const Text(
                  "Slide controller demo",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
              body: BlocBuilder<MainScreenCubit, MainScreenState>(
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
                      ],
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
