import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/question-bank/presentation/view/components/question_filter_segment.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ExamBuilderView extends StatelessWidget {
  const ExamBuilderView({super.key});

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
                  "Exam Builder",
                  style: MyTextStyle.xl1.bold,
                ),
                QuestionFilterSegment(
                  ableSelectRevision: false,
                  controllerTag: "exam-builder",
                  emitData: (value) {
                    Get.toNamed(Routes.examBuilderDetails, arguments: value);
                  },
                ),
              ],
            ).padding(const EdgeInsets.only(right: AppValues.double40))),
        Flexible(flex: 4, child: Container())
      ],
    ).padding(const EdgeInsets.symmetric(horizontal: AppValues.double20));
  }
}
