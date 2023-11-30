import 'package:camera/camera.dart';
import 'package:client/screens/setting_controller_screen/cubit/setting_controller_cubit.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/utils/camera.dart';
import 'package:client/shared/utils/permission.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:client/shared/widgets/app_dismiss_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingControllerScreen extends StatefulWidget {
  const SettingControllerScreen({super.key});

  @override
  State<SettingControllerScreen> createState() =>
      _SettingControllerScreenState();
}

class _SettingControllerScreenState extends State<SettingControllerScreen> {
  CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    AppPermission.requestCamera().then((value) {
      if (value) {
        // _loadCamera();
      }
    });
  }

  _loadCamera() {
    _cameraController = CameraController(
      AppCamera.cameras[0],
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    _cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {});
      }
    }).catchError((err) {
      if (err is CameraException) {}
    });
  }

  @override
  void dispose() {
    super.dispose();
    // _cameraController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingControllerCubit(),
      child: LayoutBuilder(
        builder: (context, constraints) => AppDismissKeyboard(
            onWillPop: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // BlocBuilder<SettingControllerCubit, SettingControllerState>(
                    //   buildWhen: (previous, current) =>
                    //       previous.onCamera != current.onCamera,
                    //   builder: (context, state) {
                    //     return Container(
                    //         width: MediaQuery.of(context).size.width,
                    //         height: MediaQuery.of(context).size.height * 0.45,
                    //         decoration: BoxDecoration(
                    //             color: AppColors.grey,
                    //             border: Border.all(color: AppColors.bgColor),
                    //             borderRadius: const BorderRadius.all(
                    //               Radius.circular(30),
                    //             )),
                    //         child: state.onCamera
                    //             ? _cameraController?.value.isInitialized ??
                    //                     false
                    //                 ? ClipRRect(
                    //                     borderRadius: const BorderRadius.all(
                    //                       Radius.circular(30),
                    //                     ),
                    //                     child:
                    //                         CameraPreview(_cameraController!))
                    //                 : const SizedBox.shrink()
                    //             : const SizedBox.shrink());
                    //   },
                    // ),
                    BlocBuilder<SettingControllerCubit, SettingControllerState>(
                      buildWhen: (previous, current) =>
                          previous.onCamera != current.onCamera,
                      builder: (context, state) {
                        return AppButton(
                            width: MediaQuery.of(context).size.width,
                            title: "${!state.onCamera ? "Mở" : "Tắt"} camera",
                            onPressed: () {
                              context
                                  .read<SettingControllerCubit>()
                                  .updateState((p0) =>
                                      p0.copyWith(onCamera: !p0.onCamera));
                            });
                      },
                    )
                  ]),
            )),
      ),
    );
  }
}
