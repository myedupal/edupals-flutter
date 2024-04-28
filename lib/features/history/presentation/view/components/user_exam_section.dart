import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/history/presentation/controller/history_controller.dart';
import 'package:edupals/features/question-bank/presentation/view/components/treding_column.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UserExamSection extends GetView<HistoryController> {
  const UserExamSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Exam",
          style: MyTextStyle.m.bold,
        ).padding(const EdgeInsets.only(top: AppValues.double10)),
        Obx(() => SizedBox(
              height: 120,
              child: controller.userExamList.isEmpty == true
                  ? Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: AppValues.double10),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You currently don't have any exam yet.",
                            style: MyTextStyle.s.medium,
                          ),
                          Text(
                            "Create Now",
                            style: MyTextStyle.xs.bold.c(AppColors.accent500),
                          ).onTap(() {
                            controller.updateNavbar();
                          })
                        ],
                      ).capsulise(radius: 10, color: AppColors.gray100),
                    )
                  : ListView(
                      // This next line does the trick.
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Row(
                          children: [
                            ...controller.userExamList
                                .map((element) => SizedBox(
                                      width: Get.width * 0.3,
                                      child: TrendingColumn(
                                        title: "${element.title}",
                                        value: "${element.subject?.name}",
                                        subvalue:
                                            "${element.subject?.curriculum?.getFullName}",
                                        withProgress: false,
                                      )
                                          .padding(const EdgeInsets.only(
                                              right: AppValues.double20))
                                          .onTap(() {
                                        controller.navigateExam(id: element.id);
                                      }),
                                    ))
                          ],
                        )
                      ],
                    ),
            ))
      ],
    );
  }
}
