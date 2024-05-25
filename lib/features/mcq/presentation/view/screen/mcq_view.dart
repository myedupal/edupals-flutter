import 'package:edupals/core/extensions/context_extensions.dart';
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

  Widget get historyList => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Past Attempt",
            style: MyTextStyle.xl.bold,
          ).padding(const EdgeInsets.only(
              top: AppValues.double10, bottom: AppValues.double20)),
          Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.submissionList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => SubmissionColumn(
                        submission: controller.submissionList?[index],
                      ).padding(
                          const EdgeInsets.only(bottom: AppValues.double20)),
                    );
                  }))
        ],
      );

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MCQController());
    return [
      Flexible(
          flex: context.isPhonePortrait ? 0 : 7,
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
              right: context.isPhonePortrait
                  ? AppValues.double0
                  : AppValues.double40,
              bottom: AppValues.double20))),
      Flexible(flex: 4, child: historyList)
    ]
        .rowToColumn(
            isActive: context.isPhonePortrait,
            rowCrossAlignment: CrossAxisAlignment.start)
        .padding(const EdgeInsets.symmetric(horizontal: AppValues.double10));
  }
}
