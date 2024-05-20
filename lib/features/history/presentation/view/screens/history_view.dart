import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/history/presentation/controller/history_controller.dart';
import 'package:edupals/features/history/presentation/view/components/history_table.dart';
import 'package:edupals/features/history/presentation/view/components/user_exam_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HistoryController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Activity",
          style: MyTextStyle.xl1.bold,
        ),
        const UserExamSection(),
        const HistoryTable()
      ],
    ).padding(const EdgeInsets.symmetric(horizontal: AppValues.double10));
  }
}
