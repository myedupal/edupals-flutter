import 'package:cached_network_image/cached_network_image.dart';
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
        );
      case 'url':
        return CachedNetworkImage(
          // placeholder: (context, url) => Center(child: _buildLoadingImage()),
          imageUrl: fileName,
          fit: fit,
          height: height,
          width: width,
          color: color,
        );
      case 'json':
      case 'zip':
        return SizedBox(
          width: width,
          height: height,
          child: Lottie.asset(
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
