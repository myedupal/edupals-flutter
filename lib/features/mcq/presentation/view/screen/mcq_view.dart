import 'package:edupals/core/components/shimmer.dart';
import 'package:edupals/core/enum/view_state.dart';
import 'package:edupals/core/extensions/context_extensions.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/core/values/app_colors.dart';
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
      buttonText: "START MY EXAM",
      ableSelectRevision: false,
      filterArgument: QuestionFilterArgument(
          revisionType: "yearly", questionFilterType: QuestionFilterType.mcq),
      controllerTag: "mcq",
      emitData: (value) {
        if (value != null) {
          Get.toNamed(Routes.challengeDetails,
              arguments: ChallengeArgument(
                  questionQueryParams: value.queryParams,
                  mainTitle:
                      "${value.subject?.label ?? ""} ${value.paper ?? ""}",
                  subjectTitle: value.title));
        }
      });

  Widget historyList(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Past Attempt",
            style: MyTextStyle.xl.bold,
          ).padding(const EdgeInsets.only(
              top: AppValues.double10, bottom: AppValues.double20)),
          Obx(() {
            switch (controller.viewState) {
              case ViewState.success:
                return ListView.builder(
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
                    });
              case ViewState.noData:
                return Container(
                  width: double.infinity,
                  height: AppValues.double100,
                  alignment: Alignment.center,
                  child: Text(
                    "Currently you don't have submission yet.\nStart MCQ Challenge now!",
                    style: MyTextStyle.s.medium,
                    textAlign: TextAlign.center,
                  ),
                ).capsulise(radius: 10, color: AppColors.gray100);
              default:
                return const Shimmer.rounded(
                    height: AppValues.double100, width: double.infinity);
            }
          }),
        ],
      );

  Widget pageBody(BuildContext context) => [
        Expanded(
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
        Expanded(
            flex: context.isPhonePortrait ? 0 : 4, child: historyList(context))
      ]
          .rowToColumn(
              isActive: context.isPhonePortrait,
              rowCrossAlignment: CrossAxisAlignment.start)
          .padding(const EdgeInsets.symmetric(horizontal: AppValues.double10));

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MCQController());
    return context.isPhonePortrait
        ? ListView(
            shrinkWrap: true,
            children: [Expanded(child: pageBody(context))],
          )
        : pageBody(context);
  }
}
