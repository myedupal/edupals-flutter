import 'package:edupals/core/base/base_button.dart';
import 'package:edupals/core/base/model/key_value.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/question-bank/presentation/controller/selection_dialog_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectionDialog extends GetView<SelectionDialogController> {
  const SelectionDialog({
    super.key,
    this.selectionList,
    this.isMultiSelect = true,
    this.numberOfColumn = 4,
    this.childRatio = 1.2,
  });

  final List<KeyValue>? selectionList;
  final bool isMultiSelect;
  final int numberOfColumn;
  final double childRatio;

  Widget selectionColumn(
      {String? title, String? subtitle, bool isSelected = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: MyTextStyle.m.bold
              .c(isSelected ? AppColors.accent500 : AppColors.gray900),
        ),
        Text(
          subtitle ?? "",
          style: MyTextStyle.s
              .c(isSelected ? AppColors.accent500 : AppColors.gray900),
        )
      ],
    ).capsulise(
        radius: 10,
        color: isSelected ? AppColors.accent100 : AppColors.white,
        border: true,
        borderColor: isSelected ? AppColors.accent500 : AppColors.gray300,
        padding: const EdgeInsets.fromLTRB(
            AppValues.double15, AppValues.double15, AppValues.double15, 0));
  }

  Widget get dataList => Obx(() => GridView.count(
        padding: const EdgeInsets.symmetric(vertical: AppValues.double20),
        primary: false,
        crossAxisCount: Get.context?.isPhone == true
            ? ((numberOfColumn) / 2).round()
            : numberOfColumn,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: childRatio,
        shrinkWrap: true,
        children: [
          ...?selectionList?.map((e) {
            final selectedData = controller.selectedList
                ?.firstWhereOrNull((element) => element?.key == e.key);
            return selectionColumn(
                    title: e.label,
                    subtitle: e.sublabel,
                    isSelected: selectedData != null)
                .onTap(() {
              controller.selectData(value: e);
            });
          }),
        ],
      ).constraintsWrapper(
          height: Get.context?.isLandscape == true
              ? Get.height * 0.7
              : Get.width * 0.7));

  @override
  Widget build(BuildContext context) {
    Get.put(SelectionDialogController());
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You have selected 2 Topics",
              style: MyTextStyle.l.bold,
            ),
            const Text(
              "Chapter 1, Chapter 2",
              style: MyTextStyle.s,
            ),
          ],
        ),
        dataList,
        Row(
          children: [
            const Spacer(),
            BaseButton(text: "Done Selection", onClick: () {})
          ],
        )
      ],
    );
  }
}
