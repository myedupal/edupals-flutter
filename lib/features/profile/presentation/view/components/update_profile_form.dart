import 'package:edupals/core/base/base_button.dart';
import 'package:edupals/core/base/base_input.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/profile/presentation/controller/update_profile_controller.dart';
import 'package:edupals/features/profile/presentation/view/screens/account_view.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UpdateProfileForm extends StatelessWidget {
  const UpdateProfileForm({super.key, this.updateType});

  final UpdateAccountType? updateType;

  Widget getFormInput({required UpdateProfileController controller}) {
    Widget form;

    switch (updateType) {
      case UpdateAccountType.profile:
        form = Column(
          children: [
            BaseInput(
              label: "New Username",
              controller: controller.usernameController,
            ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
            BaseInput(
              label: "New Phone Number",
              keyboardType: KeyboardType.number,
              controller: controller.phoneNumberController,
            ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
          ],
        );
        break;
      case UpdateAccountType.password:
        form = Column(
          children: [
            BaseInput(
              label: "Current Password",
              keyboardType: KeyboardType.password,
              controller: controller.currentPasswordController,
            ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
            BaseInput(
              label: "New Password",
              keyboardType: KeyboardType.password,
              controller: controller.newPasswordController,
            ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
            BaseInput(
              label: "Confirmation New Password",
              keyboardType: KeyboardType.password,
              controller: controller.confirmPasswordController,
            ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
          ],
        );
      default:
        form = Container();
    }

    return form;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateProfileController());
    controller.onSetUpdateType(value: updateType);

    return ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Update ${updateType?.displayTitle}",
                    style: MyTextStyle.m.bold,
                  ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
                  getFormInput(controller: controller),
                  Row(
                    children: [
                      const Spacer(),
                      BaseButton(
                          text: "I am done !",
                          isLoading: controller.isLoading,
                          onClick: () {
                            controller.onSubmit();
                          })
                    ],
                  )
                ],
              ).ignorePointer(controller.isLoading))
        ]);
  }
}
