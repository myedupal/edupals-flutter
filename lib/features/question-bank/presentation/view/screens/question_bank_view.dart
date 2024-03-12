import 'package:edupals/core/base/base_button.dart';
import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/base/model/key_value.dart';
import 'package:edupals/core/components/selection_input.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
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
      childRatio: 3,
      numberOfColumn: 2,
      selectionList: controller.revisionType,
      emitData: (data) {
        controller.onSelectRevisionType(value: data?.first);
      },
    ));
  }

  void showSubjectDialog() {
    BaseDialog.customise(
        child: SelectionDialog(
      isMultiSelect: false,
      title: "subject",
      childRatio: 2.2,
      numberOfColumn: 2,
      selectionList: controller.subjectList
          ?.map((element) => KeyValue(label: element.name, key: element.id))
          .toList(),
      emitData: (data) {
        controller.onSelectSubject(value: data?.first);
      },
    ));
  }

  void showPaperDialog() {
    BaseDialog.customise(
        child: SelectionDialog(
      isMultiSelect: false,
      title: "paper",
      childRatio: 1.5,
      numberOfColumn: 4,
      selectionList: controller.paperList ?? [],
      emitData: (data) {
        controller.onSelectPaper(value: data?.first);
      },
    ));
  }

  void showTopicDialog() {
    BaseDialog.customise(
        child: SelectionDialog(
      title: "topic",
      childRatio: 2,
      numberOfColumn: 2,
      selectionList: controller.topicList
          ?.map((element) => KeyValue(
              label: element.getChapter,
              sublabel: element.getShortName,
              key: element.id))
          .toList(),
      emitData: (data) {
        controller.onSelectTopics(value: data);
      },
    ));
  }

  void showYearDialog() {
    BaseDialog.customise(
        child: SelectionDialog(
      title: "year",
      childRatio: 1.5,
      numberOfColumn: 4,
      selectionList: controller.yearsList,
      emitData: (data) {
        controller.onSelectYears(value: data);
      },
    ));
  }

  void showSeasonDialog() {
    BaseDialog.customise(
        child: SelectionDialog(
      isMultiSelect: false,
      title: "season",
      childRatio: 1.5,
      numberOfColumn: 4,
      selectionList: controller.season,
      emitData: (data) {
        controller.onSelectSeason(value: data?.first);
      },
    ));
  }

  Widget get filterBody => Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: SelectionInput(
                  label: "Revision Type",
                  data: controller.selectedRevisionType.value,
                )
                        .padding(
                            const EdgeInsets.only(right: AppValues.double15))
                        .onTap(showRevisionDialog)),
                Expanded(
                    child: SelectionInput(
                  label: "Subject",
                  data: controller.selectedSubject.value,
                ).onTap(() {
                  if (controller.isAbleSelectSubject()) {
                    showSubjectDialog();
                  } else {
                    controller.triggerError(
                        error: "Please select a curriculum first");
                  }
                }))
              ],
            ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
            Row(
              children: [
                Expanded(
                    child: SelectionInput(
                  label: "Paper",
                  data: controller.selectedPaper.value,
                )
                        .padding(
                            const EdgeInsets.only(right: AppValues.double15))
                        .onTap(() {
                  controller.selectedSubject.value == null
                      ? controller.triggerError(
                          error: "You have to select subject first")
                      : showPaperDialog();
                })),
                Expanded(
                    child: SelectionInput(
                  label: "Season",
                  data: controller.selectedSeason.value,
                ).onTap(showSeasonDialog))
              ],
            ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
            if (controller.selectedRevisionType.value?.key == "topical") ...[
              SelectionInput(
                label: "Topics",
                isMultiSelect: true,
                dataList: [...?controller.selectedTopics],
                onRemove: (id) {
                  controller.onRemoveTopic(id);
                },
              ).onTap(() {
                controller.selectedSubject.value == null
                    ? controller.triggerError(
                        error: "You have to select subject first")
                    : showTopicDialog();
              }).padding(const EdgeInsets.only(bottom: AppValues.double20)),
              SelectionInput(
                label: "Years",
                isMultiSelect: true,
                dataList: [...?controller.selectedYears],
                onRemove: (id) {
                  controller.onRemoveYear(id);
                },
              )
                  .onTap(showYearDialog)
                  .padding(const EdgeInsets.only(bottom: AppValues.double20)),
            ],
            BaseButton(
                text: "Search Questions",
                onClick: () {
                  controller.navigatePage();
                })
          ],
        ).padding(const EdgeInsets.only(top: AppValues.double20));
      });

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
        Flexible(
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
