import 'package:edupals/core/base/base_button.dart';
import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/base/model/key_value.dart';
import 'package:edupals/core/components/selection_input.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/question-bank/domain/model/question_bank_argument.dart';
import 'package:edupals/features/question-bank/domain/model/question_filter_argument.dart';
import 'package:edupals/features/question-bank/domain/repository/subject_repository.dart';
import 'package:edupals/features/question-bank/domain/repository/topic_repository.dart';
import 'package:edupals/features/question-bank/presentation/controller/question_filter_segment_controller.dart';
import 'package:edupals/features/question-bank/presentation/view/components/selection_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class QuestionFilterSegment extends StatelessWidget {
  const QuestionFilterSegment({
    super.key,
    this.emitData,
    this.controllerTag,
    this.ableSelectRevision = true,
    this.ableSelectSubject = true,
    this.filterArgument,
  });

  final Function(QuestionBankArgument?)? emitData;
  final bool ableSelectRevision;
  final bool ableSelectSubject;
  final String? controllerTag;
  final QuestionFilterArgument? filterArgument;

  void showRevisionDialog(QuestionFilterSegmentController controller) {
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

  void showSubjectDialog(QuestionFilterSegmentController controller) {
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

  void showPaperDialog(QuestionFilterSegmentController controller) {
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

  void showTopicDialog(QuestionFilterSegmentController controller) {
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

  void showYearDialog(
      {required QuestionFilterSegmentController controller,
      bool isMultipleSelect = true}) {
    BaseDialog.customise(
        child: SelectionDialog(
      isMultiSelect: isMultipleSelect,
      title: "year",
      childRatio: 1.5,
      numberOfColumn: 4,
      selectionList: controller.yearsList,
      emitData: (data) {
        controller.onSelectYears(value: data);
      },
    ));
  }

  void showZoneDialog(QuestionFilterSegmentController controller) {
    BaseDialog.customise(
        child: SelectionDialog(
      isMultiSelect: false,
      title: "zone",
      childRatio: 1.5,
      numberOfColumn: 4,
      selectionList: controller.zoneList,
      emitData: (data) {
        controller.onSelectZone(value: data?.first);
      },
    ));
  }

  void showSeasonDialog(QuestionFilterSegmentController controller) {
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

  Widget zoneWidget(QuestionFilterSegmentController controller) =>
      SelectionInput(
        label: "Zone",
        isRequired: controller.isYearly,
        isMultiSelect: false,
        data: controller.selectedZone.value,
      ).onTap(() {
        controller.selectedSubject.value == null
            ? controller.triggerError(error: "You have to select subject first")
            : showZoneDialog(controller);
      });

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<SubjectRepository>(() => SubjectRepository());
    Get.lazyPut<TopicRepository>(() => TopicRepository());
    final controller =
        Get.put(QuestionFilterSegmentController(), tag: controllerTag);
    controller.onSetFilterArgument(value: filterArgument);
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (ableSelectRevision)
                Expanded(
                    child: SelectionInput(
                  label: "Revision Type",
                  data: controller.selectedRevisionType.value,
                )
                        .padding(
                            const EdgeInsets.only(right: AppValues.double15))
                        .onTap(() => showRevisionDialog(controller))),
              if (ableSelectSubject)
                Expanded(
                    child: SelectionInput(
                  label: "Subject",
                  isRequired: true,
                  data: controller.selectedSubject.value,
                ).onTap(() {
                  if (controller.isAbleSelectSubject()) {
                    showSubjectDialog(controller);
                  } else {
                    controller.triggerError(
                        error: "Please select a curriculum first");
                  }
                }).padding(EdgeInsets.only(
                        right: !ableSelectRevision
                            ? AppValues.double15
                            : AppValues.double0))),
              if (!ableSelectRevision) Expanded(child: zoneWidget(controller)),
            ],
          ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
          if (ableSelectRevision)
            zoneWidget(controller)
                .padding(const EdgeInsets.only(bottom: AppValues.double20)),
          Row(
            children: [
              Expanded(
                  child: SelectionInput(
                label: "Paper",
                isRequired: true,
                data: controller.selectedPaper.value,
              )
                      .padding(const EdgeInsets.only(right: AppValues.double15))
                      .onTap(() {
                controller.selectedSubject.value == null
                    ? controller.triggerError(
                        error: "You have to select subject first")
                    : showPaperDialog(controller);
              })),
              Expanded(
                  child: SelectionInput(
                label: "Season",
                isRequired: true,
                data: controller.selectedSeason.value,
              ).onTap(() => showSeasonDialog(controller)))
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
                  : showTopicDialog(controller);
            }).padding(const EdgeInsets.only(bottom: AppValues.double20)),
          ],
          SelectionInput(
            label: "Years",
            isRequired: controller.isYearly,
            isMultiSelect: !controller.isYearly,
            dataList: [...?controller.selectedYears],
            data: controller.selectedYears?.isNotEmpty == true
                ? controller.selectedYears?.first
                : null,
            onRemove: (id) {
              controller.onRemoveYear(id);
            },
          )
              .onTap(() => showYearDialog(
                  controller: controller,
                  isMultipleSelect:
                      controller.selectedRevisionType.value?.key != "yearly"))
              .padding(const EdgeInsets.only(bottom: AppValues.double20)),
          BaseButton(
              text: "Search Questions",
              onClick: () {
                if (controller.compiledValue != null) {
                  emitData?.call(controller.compiledValue);
                }
              })
        ],
      ).padding(const EdgeInsets.only(top: AppValues.double20));
    });
  }
}
