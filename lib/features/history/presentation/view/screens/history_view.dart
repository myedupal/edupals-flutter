import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/routes/routing.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/history/presentation/controller/history_controller.dart';
import 'package:edupals/features/history/presentation/view/components/history_table.dart';
import 'package:edupals/features/question-bank/domain/model/question_bank_argument.dart';
import 'package:edupals/features/question-bank/presentation/view/components/treding_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  Widget get topicsSection => Obx(() => Container(
        height: 120,
        child: ListView(
          // This next line does the trick.
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Row(
              children: [
                ...controller.userExamList.map((element) => SizedBox(
                      width: Get.width * 0.3,
                      child: TrendingColumn(
                        title: "${element.title}",
                        value: "${element.subject?.name}",
                        subvalue: "${element.subject?.curriculum?.getFullName}",
                        withProgress: false,
                      )
                          .padding(
                              const EdgeInsets.only(right: AppValues.double20))
                          .onTap(() {
                        Get.toNamed(Routes.examBuilderDetails,
                            arguments:
                                QuestionBankArgument(userExamId: element.id));
                      }),
                    ))
              ],
            )
          ],
        ),
      ));

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
        Text(
          "My Exam",
          style: MyTextStyle.m.bold,
        ).padding(const EdgeInsets.only(top: AppValues.double10)),
        topicsSection,
        const HistoryTable()
      ],
    )
        .padding(const EdgeInsets.only(right: AppValues.double40))
        .padding(const EdgeInsets.symmetric(horizontal: AppValues.double20));
  }
}
