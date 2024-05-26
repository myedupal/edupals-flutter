import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/profile/presentation/controller/profile_controller.dart';
import 'package:edupals/features/profile/presentation/view/components/profile_overview.dart';
import 'package:edupals/features/profile/presentation/view/components/profile_top_bar.dart';
import 'package:edupals/features/profile/presentation/view/screens/account_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Column(
      children: [
        const ProfileTopBar()
            .padding(const EdgeInsets.only(bottom: AppValues.double20)),
        Expanded(
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // if (!context.isPhone && context.isLandscape) const ProfileSidebar(),
          const Spacer(),
          ListView(
            children: const [ProfileOverview(), AccountView()],
          ).constraintsWrapper(
              width: Get.width *
                  (!context.isPhone && context.isLandscape ? 0.65 : 0.9),
              color: Colors.transparent),
          const Spacer(),
        ])),
      ],
    )
        .padding(
          const EdgeInsets.all(AppValues.double10),
        )
        .scaffoldWrapper(backgroundColor: Colors.transparent)
        .addBackgroundImage();
  }
}
