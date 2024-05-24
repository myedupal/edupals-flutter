import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/domain/model/challenge_argument.dart';
import 'package:edupals/features/mcq/presentation/controller/mcq_controller.dart';
import 'package:edupals/features/mcq/presentation/view/components/submission_column.dart';
import 'package:edupals/features/question-bank/domain/model/question_filter_argument.dart';
import 'package:edupals/features/question-bank/presentation/controller/question_filter_segment_controller.dart';
import 'package:edupals/features/question-bank/presentation/view/components/question_filter_segment.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MCQView extends GetView<MCQController> {
  const MCQView({super.key});

  Widget get filterBody => QuestionFilterSegment(
      ableSelectRevision: false,
      filterArgument: QuestionFilterArgument(
          revisionType: "yearly", questionFilterType: QuestionFilterType.mcq),
      controllerTag: "mcq",
      emitData: (value) {
        if (value != null) {
          Get.toNamed(Routes.challengeDetails,
              arguments: ChallengeArgument(
                  questionQueryParams: value.queryParams,
                  pageTitle: "MCQ",
                  subjectTitle: value.title));
        }
      });

  Widget get historyList => ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              "Past Attempt",
              style: MyTextStyle.xl.bold,
            ).padding(const EdgeInsets.only(top: AppValues.double10)),
            Obx(() => Column(
                  children: [
                    for (int i = 0;
                        i < (controller.submissionList?.length ?? 0);
                        i++)
                      SubmissionColumn(
                        submission: controller.submissionList?[i],
                      ).padding(
                          const EdgeInsets.only(bottom: AppValues.double20)),
                  ],
                ).padding(
                    const EdgeInsets.symmetric(vertical: AppValues.double20))),
          ]);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MCQController());
    return [
      Flexible(
          flex: context.isPhone ? 0 : 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "MCQ",
                style: MyTextStyle.xl1.bold,
              ),
              filterBody,
            ],
          ).padding(EdgeInsets.only(
              right: context.isPhone ? AppValues.double0 : AppValues.double40,
              bottom: AppValues.double20))),
      Flexible(flex: context.isPhone ? 0 : 4, child: historyList)
    ]
        .rowToColumn(
            isActive: context.isPhone,
            rowCrossAlignment: CrossAxisAlignment.start)
        .padding(const EdgeInsets.symmetric(horizontal: AppValues.double10));
  }
}
