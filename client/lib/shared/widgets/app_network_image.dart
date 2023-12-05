import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/shared/extensions/string_ext.dart';
import 'package:flutter/material.dart';

import '../../generated/assets.gen.dart';
import '../utils/app_colors.dart';

class ImageType {
  static const String avatar = 'avatar';
  static const String image = 'image';
}

class ImageModel {
  String? url;
  File? file;

  ImageModel({
    this.url,
    this.file,
  });

  copyWith({String? url, File? file}) {
    if (url.isNotEmptyOrNull) this.url = url;
    if (file != null) this.file = file;
  }
}

// ignore: must_be_immutable
class AppNetworkImage extends StatelessWidget {
  final String? url;
  final Color? backgroundColor;
  final Widget? placeholderImage;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final double? placeholderAspectRatio;
  final BorderRadius borderRadius;
  final BoxFit? fit;
  final String imageType;
  BoxConstraints? constraints;

  AppNetworkImage(
      {Key? key,
      this.url,
      this.backgroundColor = AppColors.black,
      this.placeholderImage,
      this.width,
      this.height,
      this.borderRadius = BorderRadius.zero,
      this.fit,
      this.aspectRatio,
      this.placeholderAspectRatio,
      this.constraints,
      this.imageType = ImageType.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    constraints = BoxConstraints(
        maxWidth: constraints?.maxWidth ?? double.infinity,
        maxHeight: constraints?.maxHeight ?? double.infinity);
    Widget imageWidget = ClipRRect(
        borderRadius: borderRadius,
        child: Container(
            decoration: BoxDecoration(color: backgroundColor),
            child: url == null || url!.trim().isEmpty
                ? LayoutBuilder(builder: (context, boxConstraint) {
                    double constraintBoxWidth = width ??
                        min(constraints?.maxWidth ?? double.infinity,
                            boxConstraint.maxWidth);
                    double constraintBoxHeight = height ??
                        min(constraints?.maxHeight ?? double.infinity,
                            boxConstraint.maxHeight);
                    return Container(
                        width: constraintBoxWidth,
                        height: constraintBoxHeight,
                        color: AppColors.gray,
                        child: Center(
                            child: imageType == 'image'
                                ? SizedBox(
                                    height: constraintBoxHeight / 2,
                                    width: constraintBoxWidth / 2,
                                    child: Assets.images.imageLoading
                                        .image(fit: BoxFit.contain))
                                : SizedBox(
                                    height: constraintBoxHeight / 2 * 3,
                                    width: constraintBoxWidth / 2 * 3,
                                    child: Assets.images.imageLoading
                                        .image(fit: BoxFit.contain))));
                  })
                : CachedNetworkImage(
                    imageUrl: url!,
                    maxWidthDiskCache: 1260,
                    maxHeightDiskCache: 1260,
                    errorWidget: (context, _, __) =>
                        LayoutBuilder(builder: (context, constrain) {
                      return Container(
                          width: constrain.maxWidth,
                          height: constrain.maxHeight,
                          color: AppColors.gray,
                          child: Center(
                              child: SizedBox(
                                  height: constrain.maxHeight / 2,
                                  width: constrain.maxWidth / 2,
                                  child: Assets.images.imageLoading
                                      .image(fit: BoxFit.contain))));
                    }),
                    placeholder: (context, _) =>
                        LayoutBuilder(builder: (context, constrain) {
                      return Container(
                          width: constrain.maxWidth,
                          height: aspectRatio != null ||
                                  placeholderAspectRatio != null
                              ? (aspectRatio ?? placeholderAspectRatio)! *
                                  constrain.maxWidth
                              : constrain.maxHeight,
                          color: AppColors.gray,
                          child: Center(
                              child: SizedBox(
                                  height: constrain.maxHeight / 2,
                                  width: constrain.maxWidth / 2,
                                  child: Assets.images.imageLoading
                                      .image(fit: BoxFit.contain))));
                    }),
                    fit: fit ?? BoxFit.contain,
                  )));
    if (aspectRatio != null) {
      return SizedBox(
          width: width,
          height: height ?? width,
          child: AspectRatio(aspectRatio: aspectRatio!, child: imageWidget));
    }
    return SizedBox(width: width, height: height, child: imageWidget);
  }
}
