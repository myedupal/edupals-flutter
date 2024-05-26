import 'package:cached_network_image/cached_network_image.dart';
import 'package:edupals/core/components/shimmer.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class ImageAssetView extends StatelessWidget {
  const ImageAssetView(
      {required this.fileName,
      this.height,
      this.fit,
      this.width,
      this.color,
      this.scale,
      Key? key})
      : super(key: key);

  final Color? color;
  final String fileName;
  final BoxFit? fit;
  final double? height;
  final double? scale;
  final double? width;

  Widget get getImage {
    final String mimType =
        fileName.contains("https://") ? "url" : fileName.split('.').last;

    if (mimType.isEmpty) {
      return Icon(
        Icons.image_not_supported_outlined,
        size: width,
        color: color,
      );
    }

    switch (mimType) {
      case 'svg':
        return SvgPicture.asset(
          fileName,
          height: height,
          width: width,
          fit: fit ?? BoxFit.fitHeight,
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        );
      case 'png':
      case 'jpg':
      case 'jpeg':
        return Image.asset(
          fileName,
          fit: fit,
          height: height,
          width: width,
          color: color,
          scale: scale,
          gaplessPlayback: true,
        );
      case 'url':
        return CachedNetworkImage(
          placeholder: (context, url) => const Shimmer.rounded(
            height: AppValues.double100,
            width: double.infinity,
          ),
          httpHeaders: const {'Access-Control-Allow-Origin': '*'},
          imageUrl: fileName,
          fit: fit,
          height: height,
          width: width,
          color: color,
          errorWidget: (context, url, error) {
            return const ImageAssetView(
              fileName: AppAssets.imageError,
              color: AppColors.gray500,
            );
          },
        );
      case 'json':
      case 'zip':
        return SizedBox(
          width: width,
          height: height,
          child: Lottie.asset(
            frameRate: FrameRate.max,
            fileName,
            fit: BoxFit.cover,
            repeat: true,
          ),
        );
      default:
        return Icon(
          Icons.image_not_supported_outlined,
          size: width,
          color: color,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return getImage;
  }
}
