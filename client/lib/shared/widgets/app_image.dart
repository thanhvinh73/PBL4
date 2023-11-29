import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/generated/assets.gen.dart';
import 'package:client/shared/extensions/string_ext.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class AppImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String? url;
  final String? assetUrl;
  final BorderRadius borderRadius;
  final BoxFit fit;
  final File? file;
  final EdgeInsets imagePadding;
  final Color backgroundColor;
  const AppImage(
      {this.url,
      this.assetUrl,
      this.borderRadius = BorderRadius.zero,
      this.width,
      this.height,
      this.fit = BoxFit.cover,
      this.file,
      this.backgroundColor = AppColors.transparent,
      this.imagePadding = EdgeInsets.zero,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(color: backgroundColor),
          padding: imagePadding,
          child: Builder(builder: (context) {
            if (file != null) {
              return Image.file(
                file!,
                fit: fit,
              );
            } else if (url.isNotEmptyOrNull) {
              return CachedNetworkImage(
                imageUrl: url!,
                fit: fit,
                placeholder: (context, url) => imagePlaceHolder,
                errorWidget: (context, url, error) => imagePlaceHolder,
              );
            } else if (assetUrl.isNotEmptyOrNull) {
              return SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  assetUrl!,
                  fit: fit,
                ),
              );
            }
            return imagePlaceHolder;
          })),
    );
  }
}

Widget get imagePlaceHolder => LayoutBuilder(builder: (context, constraint) {
      return Container(
        color: AppColors.gray,
        padding: EdgeInsets.all(
            min(12.0, min(constraint.maxHeight, constraint.maxWidth) / 4)),
        child: Center(
          child: Assets.images.imageLoading.image(),
        ),
      );
    });
