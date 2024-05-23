import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/components/loading_view.dart';
import 'package:edupals/core/components/no_data_view.dart';
import 'package:edupals/core/enum/view_state.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/question-bank/presentation/controller/questions_list_controller.dart';
import 'package:edupals/features/question-bank/presentation/view/components/chapter_display_list.dart';
import 'package:edupals/features/question-bank/presentation/view/components/question_action_list.dart';
import 'package:edupals/features/question-bank/presentation/view/components/question_display_list.dart';
import 'package:edupals/features/question-bank/presentation/view/components/questions_list_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionsListView extends GetView<QuestionsListController> {
  const QuestionsListView({super.key});

  Widget get pageBody {
    return Obx(() {
      switch (controller.viewState) {
        case ViewState.loading:
          return const LoadingView();
        case ViewState.noData:
          return const NoDataView(message: "There is no question for you...");
        default:
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.isYearly
                  ? const Expanded(flex: 1, child: QuestionDisplayList())
                  : const Expanded(flex: 3, child: ChapterDisplayList()),
              Expanded(flex: 8, child: questionDetails),
              actionList
            ],
          ).padding(const EdgeInsets.symmetric(
              horizontal: AppValues.double10, vertical: AppValues.double25));
      }
    });
  }

  Widget get actionList => QuestionActionList(
        action: (value) {
          controller.questionAction(value);
        },
      );

  Widget get questionDetails => Obx(() {
        final selectedQuestion = controller.selectedQuestion.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Q${selectedQuestion?.number} ${selectedQuestion?.exam?.year} ${selectedQuestion?.exam?.season} ${selectedQuestion?.exam?.zone}",
              style: MyTextStyle.xxl.bold,
            ),
            Expanded(
                child: ListView(shrinkWrap: true, children: [
              Column(
                children: [
                  ...?selectedQuestion?.questionImages?.map((e) =>
                      ImageAssetView(fileName: e.image?.url ?? "").padding(
                          const EdgeInsets.only(bottom: AppValues.double50)))
                ],
              ).padding(
                  const EdgeInsets.symmetric(vertical: AppValues.double20))
            ]))
          ],
        ).padding(const EdgeInsets.symmetric(horizontal: AppValues.double40));
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuestionsListTopBar(
          titleList: [
            controller.mainController.selectedCurriculum.value?.getFullName ??
                "",
            ...controller.titleList
          ],
        ),
        Expanded(child: pageBody)
      ],
    ).padding(const EdgeInsets.all(AppValues.double10)).scaffoldWrapper();
  }
}
