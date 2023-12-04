import 'dart:async';

import 'package:client/generated/assets.gen.dart';
import 'package:client/generated/translations.g.dart';
import 'package:client/routes/app_router.dart';
import 'package:client/screens/splash_screen/cubit/splash_screen_cubit.dart';
import 'package:client/shared/helpers/dialog_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _debound = Debouncer(delay: const Duration(seconds: 1));
  late final StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.wifi:
          debugPrint("WIFI: on");
          break;
        case ConnectivityResult.none:
          debugPrint("WIFI: off");
          break;

        default:
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

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
                      previous.errorMessage != current.errorMessage &&
                      current.errorMessage != null,
                  listener: (context, state) {
                    showErrorDialog(context,
                            title: tr(LocaleKeys.Auth_Error),
                            content: state.errorMessage)
                        .then((value) => context
                            .read<SplashScreenCubit>()
                            .resetErrorMessage());
                  },
                ),
                BlocListener<SplashScreenCubit, SplashScreenState>(
                  listenWhen: (previous, current) =>
                      previous.isInit != current.isInit,
                  listener: (context, state) {
                    Get.toNamed(Routes.connectToServer);
                  },
                ),
              ],
              child: LayoutBuilder(builder: (context, constraints) {
                _debound.call(() => context
                    .read<SplashScreenCubit>()
                    .updateState((p0) => p0.copyWith(isInit: true)));
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Assets.images.pcAi.image(),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
