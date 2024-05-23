import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/base/base_divider.dart';
import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/base/model/key_value.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/profile/presentation/controller/profile_controller.dart';
import 'package:edupals/features/profile/presentation/view/components/update_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum UpdateAccountType {
  profile("Profile"),
  password("Password"),
  phoneNumber("Phone Number"),
  email("Email Address");

  const UpdateAccountType(this.displayTitle);

  final String? displayTitle;
}

class AccountView extends GetView<ProfileController> {
  const AccountView({super.key});

  Widget _displayColumn({KeyValue? value, bool? isDisplayDivider = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value?.label ?? "",
                  style: MyTextStyle.l.bold,
                ),
                if (value?.sublabel?.isNotEmpty == true)
                  Text(
                    value?.sublabel ?? "",
                    style: MyTextStyle.m,
                  ).padding(const EdgeInsets.only(top: AppValues.double10)),
              ],
            )),
            Text(
              "${value?.buttonText}",
              style: MyTextStyle.xs.medium.c(value?.type != "danger"
                  ? AppColors.gray900
                  : AppColors.white),
            )
                .capsulise(
                    radius: 100,
                    border: value?.type != "danger",
                    borderColor: AppColors.gray400,
                    color: value?.type != "danger"
                        ? Colors.transparent
                        : AppColors.red600,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppValues.double15,
                        vertical: AppValues.double12))
                .onTap(() {
              value?.onAction?.call();
            }),
          ],
        ).padding(const EdgeInsets.symmetric(vertical: AppValues.double10)),
        if (isDisplayDivider == true) const BaseDivider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
    final actionList = [
      KeyValue(
          label: "Profile",
          sublabel: "Change your current username, display name",
          buttonText: "Edit Your profile",
          onAction: () {
            BaseDialog.customise(
                child: const UpdateProfileForm(
                    updateType: UpdateAccountType.profile));
          },
          color: null),
      KeyValue(
        label: "Wallet Address",
        buttonText: "View Your Address",
        onAction: () {
          BaseDialog.customise(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ImageAssetView(
                fileName: AppAssets.suiLogo,
                width: AppValues.double100,
                height: AppValues.double100,
              ),
              const Text(
                "Sui Wallet Address",
                style: MyTextStyle.l,
              ).padding(const EdgeInsets.only(
                  top: AppValues.double20, bottom: AppValues.double20)),
              Text(
                "${mainController.suiAddress}",
                style: MyTextStyle.s,
              ).capsulise(
                  radius: 10,
                  border: true,
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(AppValues.double20))
            ],
          ));
        },
      ),
      KeyValue(
        label: "Password and Authentication",
        sublabel: "",
        buttonText: "Edit password",
        onAction: () {
          BaseDialog.customise(
              child: const UpdateProfileForm(
                  updateType: UpdateAccountType.password));
        },
      ),
      KeyValue(
          label: "Logout",
          sublabel: "",
          buttonText: "Take a short break",
          onAction: () {
            controller.logout();
          },
          type: "danger"),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...actionList.map(
          (e) =>
              _displayColumn(value: e, isDisplayDivider: e != actionList.last),
        ),
      ],
    ).padding(const EdgeInsets.symmetric(vertical: AppValues.double20));
  }
}
