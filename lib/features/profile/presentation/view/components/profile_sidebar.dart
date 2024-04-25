import 'package:edupals/core/base/base_divider.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSidebar extends GetView<ProfileController> {
  const ProfileSidebar({super.key});

  Widget _titleLabel({String? label = ""}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label",
          style: MyTextStyle.s.bold,
        ).padding(const EdgeInsets.only(left: AppValues.double10)),
        const BaseDivider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppValues.double15),
      width: Get.width * 0.25,
      padding: const EdgeInsets.only(
          left: AppValues.double20, right: AppValues.double20),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...controller.menuList.map((e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _titleLabel(label: e.label?.toUpperCase()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...?e.keyValueList?.map((e) => Obx(() => SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "${e.label}",
                                  style: MyTextStyle.s,
                                )
                                    .capsulise(
                                        radius: 8,
                                        color:
                                            controller.selectedMenu.value == e
                                                ? AppColors.gray100
                                                : Colors.transparent,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: AppValues.double12,
                                            horizontal: AppValues.double15))
                                    .onTap(() {
                                  controller.onSelectMenu(menu: e);
                                }),
                              )))
                        ],
                      )
                    ],
                  ).padding(const EdgeInsets.only(bottom: AppValues.double15)))
            ],
          )
        ],
      ),
    );
  }
}
