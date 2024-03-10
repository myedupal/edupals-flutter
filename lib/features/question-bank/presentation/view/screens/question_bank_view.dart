import 'package:edupals/core/base/base_button.dart';
import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/base/model/key_value.dart';
import 'package:edupals/core/components/selection_input.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/question-bank/domain/repository/subject_repository.dart';
import 'package:edupals/features/question-bank/domain/repository/topic_repository.dart';
import 'package:edupals/features/question-bank/presentation/controller/question_bank_controller.dart';
import 'package:edupals/features/question-bank/presentation/view/components/selection_dialog.dart';
import 'package:edupals/features/question-bank/presentation/view/components/treding_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionBankView extends GetView<QuestionBankController> {
  const QuestionBankView({super.key});

  void showRevisionDialog() {
    BaseDialog.customise(
        child: SelectionDialog(
      isMultiSelect: false,
      numberOfColumn: 2,
      childRatio: 4,
      selectionList: [
        KeyValue(label: "Yearly", key: "yearly"),
        KeyValue(label: "Topical", key: "topical")
      ],
      emitData: (data) {
        debugPrint("${data?.map((e) => e?.label)}");
      },
    ));
  }

  void showSubjectDialog() {
    BaseDialog.customise(
        child: SelectionDialog(
      isMultiSelect: false,
      title: "Subject",
      childRatio: 3,
      numberOfColumn: 2,
      selectionList: controller.subjectList
          ?.map((element) => KeyValue(label: element.name, key: element.id))
          .toList(),
      emitData: (data) {
        controller.onSelectSubject(value: data?.first);
        debugPrint("${data?.map((e) => e?.label)}");
      },
    ));
  }

  void showPaperDialog() {
    BaseDialog.customise(
        child: SelectionDialog(
      isMultiSelect: false,
      title: "Paper",
      childRatio: 3,
      numberOfColumn: 2,
      selectionList: controller.paperList ?? [],
      emitData: (data) {
        debugPrint("${data?.map((e) => e?.label)}");
      },
    ));
  }

  void showTopicDialog() {
    BaseDialog.customise(
        child: SelectionDialog(
      isMultiSelect: true,
      title: "Topic",
      childRatio: 3,
      numberOfColumn: 2,
      selectionList: controller.topicList
          ?.map((element) => KeyValue(label: element.name, key: element.id))
          .toList(),
      emitData: (data) {
        debugPrint("${data?.map((e) => e?.label)}");
      },
    ));
  }

  Widget get filterBody => Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: SelectionInput(
                label: "Revision Type",
                data: [KeyValue(label: "Yearly")],
              )
                      .padding(const EdgeInsets.only(right: AppValues.double15))
                      .onTap(showRevisionDialog)),
              Expanded(
                  child: SelectionInput(
                label: "Subject",
                data: [controller.selectedSubject.value!],
              ).onTap(showSubjectDialog))
            ],
          ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
          Row(
            children: [
              Expanded(
                  child: SelectionInput(
                label: "Paper",
                data: [KeyValue(label: "Paper 1")],
              )
                      .padding(const EdgeInsets.only(right: AppValues.double15))
                      .onTap(showPaperDialog)),
              Expanded(
                  child: SelectionInput(
                label: "Season",
                data: [KeyValue(label: "Winter")],
              ))
            ],
          ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
          SelectionInput(
            label: "Topics",
            data: [
              KeyValue(label: "Arithematics"),
              KeyValue(label: "Polynomial"),
              KeyValue(label: "Algebra")
            ],
          )
              .padding(const EdgeInsets.only(bottom: AppValues.double20))
              .onTap(showTopicDialog),
          SelectionInput(
            label: "Years",
            data: [KeyValue(label: "2020"), KeyValue(label: "2021")],
          ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
          BaseButton(
              text: "Search Questions",
              onClick: () {
                Get.toNamed(Routes.questionsList);
              })
        ],
      ).padding(const EdgeInsets.only(top: AppValues.double20)));

  Widget get trendingSection => ListView(shrinkWrap: true, children: [
        Text(
          "Trending Yearly",
          style: MyTextStyle.xl.bold,
        ),
        Column(
          children: [
            const TrendingColumn(
              percentage: 50,
            ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
            const TrendingColumn(
              percentage: 30,
            ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
            const TrendingColumn(
              percentage: 10,
            ),
          ],
        ).padding(const EdgeInsets.symmetric(vertical: AppValues.double20)),
        Text(
          "Trending Topical",
          style: MyTextStyle.xl.bold,
        ),
        Column(
          children: [
            const TrendingColumn(
              percentage: 30,
            ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
            const TrendingColumn(
              percentage: 10,
            ),
          ],
        ).padding(const EdgeInsets.symmetric(vertical: AppValues.double20)),
      ]);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<SubjectRepository>(() => SubjectRepository());
    Get.lazyPut<TopicRepository>(() => TopicRepository());
    Get.put<QuestionBankController>(QuestionBankController());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Question Bank",
                  style: MyTextStyle.xl1.bold,
                ),
                filterBody,
              ],
            ).padding(const EdgeInsets.only(right: AppValues.double40))),
        Flexible(flex: 4, child: trendingSection)
      ],
    ).padding(const EdgeInsets.symmetric(horizontal: AppValues.double20));
  }
}
