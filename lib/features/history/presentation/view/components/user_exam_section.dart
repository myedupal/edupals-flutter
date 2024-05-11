import 'package:edupals/core/components/shimmer.dart';
import 'package:edupals/core/enum/view_state.dart';
import 'package:edupals/core/extensions/context_extensions.dart';
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

  Widget get getDataBody {
    switch (controller.userExamState.value) {
      case ViewState.loading || ViewState.initial:
        return Row(
          children: [
            Shimmer.rounded(height: double.infinity, width: Get.width * 0.3),
          ],
        );
      case ViewState.success:
        return ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Row(
              children: [
                ...controller.userExamList.map((element) => SizedBox(
                      width: Get.dynamicWidth * 0.3,
                      child: TrendingColumn(
                        title: "${element.title}",
                        value: "${element.subject?.name}",
                        subvalue: "${element.subject?.curriculum?.getFullName}",
                        withProgress: false,
                      )
                          .padding(
                              const EdgeInsets.only(right: AppValues.double20))
                          .onTap(() {
                        controller.navigateExam(id: element.id);
                      }),
                    ))
              ],
            )
          ],
        );
      case ViewState.noData:
        return SizedBox(
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
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Exam",
          style: MyTextStyle.m.bold,
        ).padding(const EdgeInsets.only(top: AppValues.double10)),
        Obx(() => Container(
              height: 100,
              margin: const EdgeInsets.symmetric(vertical: AppValues.double10),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: getDataBody,
              ),
            ))
      ],
    );
  }
}
