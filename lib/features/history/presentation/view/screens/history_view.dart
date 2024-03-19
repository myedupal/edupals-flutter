import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/history/presentation/controller/history_controller.dart';
import 'package:edupals/features/history/presentation/view/components/history_table.dart';
import 'package:edupals/features/question-bank/presentation/view/components/treding_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  Widget get topicsSection => Container(
        margin: const EdgeInsets.only(top: AppValues.double20),
        height: 120,
        child: ListView(
          // This next line does the trick.
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Row(
              children: [
                for (int i = 0; i < 10; i++)
                  SizedBox(
                    width: Get.width * 0.3,
                    child: const TrendingColumn().padding(
                        const EdgeInsets.only(right: AppValues.double20)),
                  )
              ],
            )
          ],
        ),
      );

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
        topicsSection
            .padding(const EdgeInsets.only(bottom: AppValues.double20)),
        const HistoryTable()
      ],
    )
        .padding(const EdgeInsets.only(right: AppValues.double40))
        .padding(const EdgeInsets.symmetric(horizontal: AppValues.double20));
  }
}
