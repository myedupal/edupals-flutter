import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
    return Obx(() => ImageAssetView(
          fileName: mainController.currentUser.value?.oauth2ProfilePictureUrl ??
              AppAssets.profilePlaceholder,
          fit: BoxFit.cover,
          width: size ?? AppValues.double25,
          height: size ?? AppValues.double25,
        ).clip());
  }
}
