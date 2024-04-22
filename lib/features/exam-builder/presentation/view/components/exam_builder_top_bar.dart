import 'package:edupals/core/base/base_button.dart';
import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/base/base_input.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/exam-builder/presentation/controller/exam_builder_details_controller.dart';
import 'package:edupals/features/question-bank/presentation/view/components/question_filter_segment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamBuilderTopBar extends GetView<ExamBuilderDetailsController> {
  const ExamBuilderTopBar({
    super.key,
  });

  void displayNameDialog() {
    BaseDialog.customise(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Please enter your desire name",
          style: MyTextStyle.m.bold,
        ),
        BaseInput(
          label: "Name",
          maxLength: 50,
          controller: controller.nameController,
        ).padding(const EdgeInsets.symmetric(vertical: AppValues.double20)),
        BaseButton(
            text: "Use This Name!",
            onClick: () {
              controller.submitName();
              Get.back();
            })
      ],
    ));
  }

  void displaySearch() {
    BaseDialog.customise(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Search Question",
          style: MyTextStyle.l.bold,
        ),
        QuestionFilterSegment(
          ableSelectSubject: false,
          ableSelectRevision: false,
          controllerTag: "exam-builder",
          emitData: (value) {
            controller.onSearchQuestions(value: value);
            Get.back();
          },
        )
      ],
    ));
  }

  Widget topBarItem({String? title, String? icon, bool withDivider = true}) {
    return Row(
      children: [
        Text(
          title ?? "",
          style: MyTextStyle.s.bold,
        ),
        if (icon?.isNotEmpty == true)
          ImageAssetView(
            fileName: icon ?? "",
            width: AppValues.double12,
          )
              .capsulise(
                  radius: 100,
                  color: AppColors.gray200,
                  padding: const EdgeInsets.all(AppValues.double8))
              .padding(const EdgeInsets.only(left: AppValues.double10)),
        if (withDivider)
          const VerticalDivider(
            thickness: 1,
            color: AppColors.gray400,
          ).padding(const EdgeInsets.only(right: AppValues.double2)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Row(
          children: [
            const ImageAssetView(
              fileName: AppAssets.backIcon,
              height: AppValues.double12,
            )
                .capsulise(
                    radius: 100,
                    color: AppColors.gray900,
                    padding: const EdgeInsets.all(AppValues.double12))
                .padding(const EdgeInsets.only(right: AppValues.double10))
                .onTap(() {
              Get.back();
            }),
            Obx(
              () => IntrinsicHeight(
                  child: Row(
                children: [
                  topBarItem(
                          title: controller.examName?.value.isEmpty == true
                              ? "Your exam name"
                              : controller.examName?.value,
                          icon: (controller.ableEdit.value)
                              ? AppAssets.edit
                              : null,
                          withDivider: controller.ableEdit.value)
                      .onTap(() {
                    if (controller.ableEdit.value) displayNameDialog();
                  }),
                  if (controller.ableEdit.value) ...[
                    topBarItem(
                        title:
                            "${controller.selectedQuestions.length} questions added",
                        icon: AppAssets.eyeOpen),
                    topBarItem(
                            title: "Search Questions",
                            withDivider: false,
                            icon: AppAssets.search)
                        .onTap(() {
                      displaySearch();
                    }),
                  ]
                ],
              ).capsulise(
                      radius: 100,
                      color: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: AppValues.double10,
                          horizontal: AppValues.double15))),
            )
          ],
        )),
        Text(
          "FAQ",
          style: MyTextStyle.s.bold,
        ).padding(const EdgeInsets.only(right: AppValues.double20)),
        Obx(() => (controller.ableEdit.value)
            ? Text(
                "Save Exam",
                style: MyTextStyle.s.bold.c(AppColors.white),
              )
                .capsulise(
                    radius: 100,
                    color: AppColors.accent500,
                    padding: const EdgeInsets.symmetric(
                        vertical: AppValues.double12,
                        horizontal: AppValues.double15))
                .onTap(() {
                controller.apiUserExam.value == null
                    ? controller.createUserExam()
                    : controller.updateUserExam();
              })
            : Text(
                "Edit Exam",
                style: MyTextStyle.s.bold.c(AppColors.gray900).underline,
              )
                .padding(const EdgeInsets.only(right: AppValues.double20))
                .onTap(() {
                controller.ableEdit.value = true;
              })),
      ],
    ).capsulise(
        radius: 100,
        color: AppColors.gray100,
        padding: const EdgeInsets.all(AppValues.double10));
  }
}
