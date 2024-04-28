import 'package:edupals/core/base/base_button.dart';
import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/base/base_input.dart';
import 'package:edupals/core/base/model/key_value.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/profile/presentation/controller/update_profile_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UpdateProfileForm extends GetView<UpdateProfileController> {
  const UpdateProfileForm({super.key, this.updateType});

  final KeyValue? updateType;

  @override
  Widget build(BuildContext context) {
    Get.put(UpdateProfileController());
    return ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Update Profile",
                style: MyTextStyle.m.bold,
              ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
              const BaseInput(
                label: "New Username",
              ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
              const BaseInput(
                label: "New Username",
              ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
              const BaseInput(
                label: "New Username",
              ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
              Row(
                children: [
                  const Spacer(),
                  BaseButton(
                      text: "I am done !",
                      onClick: () {
                        BaseDialog.showSuccess(
                          message: "You have successfully updated profile!",
                          action: () {
                            Get.until((route) => Get.isDialogOpen == false);
                          },
                        );
                      })
                ],
              )
            ],
          )
        ]);
  }
}
