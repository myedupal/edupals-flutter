import 'package:edupals/core/extensions/context_extensions.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/domain/model/challenge_argument.dart';
import 'package:edupals/features/question-bank/domain/model/question_filter_argument.dart';
import 'package:edupals/features/question-bank/presentation/controller/question_filter_segment_controller.dart';
import 'package:edupals/features/question-bank/presentation/view/components/question_filter_segment.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MCQView extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            flex: 7,
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
                    : AppValues.double40))),
        if (!context.isPhonePortrait) Flexible(flex: 4, child: Container())
      ],
    ).padding(const EdgeInsets.symmetric(horizontal: AppValues.double10));
  }
}
