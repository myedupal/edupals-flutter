import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/components/layout_top_bar.dart';
import 'package:edupals/core/components/nav_item.dart';
import 'package:edupals/core/extensions/list_extensions.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Navbar extends GetView<MainController> {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LayoutTopBar()
            .padding(const EdgeInsets.only(bottom: AppValues.double20)),
        Obx(() => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.only(right: AppValues.double20),
                width: AppValues.double80,
                child: Column(
                  children: [
                    ...controller.navList.mapIndexed((i, e) => NavItem(
                          name: e,
                          isActive: controller.selectedNavIndex.value == i,
                        ).onTap(() {
                          controller.selectedNavIndex.value = i;
                        }).padding(
                            const EdgeInsets.only(bottom: AppValues.double20)))
                  ],
                ),
              ),
              Expanded(child: controller.getCurrentPage)
            ])),
      ],
    )
        .padding(
          const EdgeInsets.all(AppValues.double10),
        )
        .scaffoldWrapper();
  }
}
