import 'package:edupals/features/exam-builder.dart/presentation/controller/exam_builder_details_controller.dart';
import 'package:get/get.dart';

class ExamBuilderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExamBuilderDetailsController>(
        () => ExamBuilderDetailsController());
  }
}
