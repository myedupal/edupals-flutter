import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/components/layout_top_bar.dart';
import 'package:edupals/core/components/nav_item.dart';
import 'package:edupals/core/extensions/context_extensions.dart';
import 'package:edupals/core/extensions/list_extensions.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Navbar extends GetView<MainController> {
  const Navbar({super.key});

  Widget navChild(BuildContext context) {
    return Container(
      color: context.isPhonePortrait ? AppColors.white : Colors.transparent,
      child: [
        ...controller.navList.mapIndexed((i, e) => NavItem(
              name: e,
              isActive: controller.selectedNavIndex.value == i,
            ).onTap(() {
              controller.onSetNavIndex(i);
            }).padding(EdgeInsets.only(
                bottom: context.isPhonePortrait
                    ? AppValues.double10
                    : AppValues.double20,
                top: context.isPhonePortrait
                    ? AppValues.double10
                    : AppValues.double0)))
      ]
          .columnToRow(
              isActive: context.isPhonePortrait,
              rowMainAlignment: MainAxisAlignment.spaceEvenly)
          .padding(const EdgeInsets.symmetric(horizontal: AppValues.double10)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            const LayoutTopBar()
                .padding(const EdgeInsets.all(AppValues.double10)),
            Expanded(
                child: [
              if (!context.isPhonePortrait) navChild(context),
              Expanded(
                  child: controller.getCurrentPage.padding(
                      const EdgeInsets.symmetric(
                          horizontal: AppValues.double10))),
              if (context.isPhonePortrait) navChild(context),
            ].rowToColumn(
                    isActive: context.isPhonePortrait,
                    columnCrossAlignment: CrossAxisAlignment.center)),
          ],
        )
            .scaffoldWrapper(
                backgroundColor: controller.selectedNavIndex.value != 0
                    ? Colors.transparent
                    : AppColors.white)
            .addBackgroundImage(
                isDisplay:
                    ![0, 3].contains(controller.selectedNavIndex.value)));
  }
}
