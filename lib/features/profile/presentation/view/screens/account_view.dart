import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/base/base_divider.dart';
import 'package:edupals/core/base/model/key_value.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/profile/presentation/view/components/update_profile_form.dart';
import 'package:flutter/widgets.dart';

enum UpdateAccountType {
  profile("Profile"),
  password("Password"),
  phoneNumber("Phone Number"),
  email("Email Address");

  const UpdateAccountType(this.displayTitle);

  final String? displayTitle;
}

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  Widget _displayColumn({KeyValue? value, bool? isDisplayDivider = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value?.label ?? "",
              style: MyTextStyle.l.bold,
            ).padding(const EdgeInsets.only(bottom: AppValues.double10)),
            if (value?.sublabel?.isNotEmpty == true)
              Text(
                value?.sublabel ?? "",
                style: MyTextStyle.m,
              ).padding(const EdgeInsets.only(bottom: AppValues.double10)),
            Text(
              "${value?.buttonText}",
              style: MyTextStyle.xs.bold.c(AppColors.white),
            ).topBarCapsule(color: value?.color).onTap(() {
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
    final actionList = [
      KeyValue(
          label: "Edit Profile",
          sublabel: "Change your current username, display name",
          buttonText: "Edit profile",
          onAction: () {
            BaseDialog.customise(
                child: const UpdateProfileForm(
                    updateType: UpdateAccountType.profile));
          },
          color: null),
      // KeyValue(
      //     label: "Email Address",
      //     sublabel: "Edit email address",
      //     buttonText: "Edit email address",
      //     onAction: () {
      //       BaseDialog.customise(
      //           child: const UpdateProfileForm(
      //               updateType: UpdateAccountType.email));
      //     },
      //     color: null),
      // KeyValue(
      //     label: "Phone Number",
      //     sublabel: "Edit phone number",
      //     buttonText: "Edit phone number",
      //     onAction: () {
      //       BaseDialog.customise(
      //           child: const UpdateProfileForm(
      //               updateType: UpdateAccountType.phoneNumber));
      //     },
      //     color: null),
      KeyValue(
          label: "Password and Authentication",
          sublabel: "",
          buttonText: "Change password",
          onAction: () {
            BaseDialog.customise(
                child: const UpdateProfileForm(
                    updateType: UpdateAccountType.password));
          },
          color: null),
      KeyValue(
          label: "Account Removal",
          sublabel: "",
          buttonText: "Take a short break",
          onAction: () {},
          color: AppColors.red600)
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...actionList.map(
          (e) =>
              _displayColumn(value: e, isDisplayDivider: e != actionList.last),
        )
      ],
    ).padding(const EdgeInsets.symmetric(vertical: AppValues.double20));
  }
}
