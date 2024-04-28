import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/components/no_data_view.dart';
import 'package:edupals/core/enum/view_state.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/exam-builder/presentation/controller/exam_builder_details_controller.dart';
import 'package:edupals/features/exam-builder/presentation/view/components/exam_builder_top_bar.dart';
import 'package:edupals/features/exam-builder/presentation/view/components/exam_chapter_display_list.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ExamBuilderDetailsView extends GetView<ExamBuilderDetailsController> {
  const ExamBuilderDetailsView({super.key});

  Widget get pageBody {
    return Obx(() {
      switch (controller.viewState) {
        case ViewState.loading:
          return Column(
            children: [
              SizedBox(
                height: Get.width * 0.1,
              ),
              ImageAssetView(
                fileName: AppAssets.questionLoadingLottie,
                width: Get.width * 0.25,
              ),
              Text(
                "We are preparing the best for you...",
                style: MyTextStyle.l.bold,
              )
            ],
          );
        case ViewState.noData:
          return const NoDataView(message: "There is no question for you...");
        default:
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(flex: 3, child: ExamChapterDisplayList()),
              Expanded(flex: 8, child: questionDetails),
            ],
          ).padding(const EdgeInsets.symmetric(
              horizontal: AppValues.double10, vertical: AppValues.double25));
      }
    });
  }

  Widget get questionDetails => Obx(() {
        final selectedQuestion = controller.selectedQuestion.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Q${selectedQuestion?.number ?? ""} ${selectedQuestion?.exam?.year ?? ""} ${selectedQuestion?.exam?.season ?? ""} ${selectedQuestion?.exam?.zone ?? ""}",
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
      children: [const ExamBuilderTopBar(), Expanded(child: pageBody)],
    ).padding(const EdgeInsets.all(AppValues.double10)).scaffoldWrapper();
  }
}
