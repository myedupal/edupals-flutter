import 'dart:convert';

import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/base/model/key_value.dart';
import 'package:edupals/core/repositories/local_repository.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/features/auth/domain/repository/auth_repository.dart';
import 'package:edupals/features/dashboard/domain/model/curriculum.dart';
import 'package:edupals/features/dashboard/domain/repository/curriculum_repository.dart';
import 'package:edupals/features/dashboard/presentation/view/screens/dashboard_view.dart';
import 'package:edupals/features/history/presentation/view/screens/history_view.dart';
import 'package:edupals/features/question-bank/presentation/view/components/selection_dialog.dart';
import 'package:edupals/features/question-bank/presentation/view/screens/question_bank_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Global use controller
class MainController extends GetxController {
  final AuthRepository authRepo = Get.find();
  final LocalRepository localRepo = Get.find();
  final CurriculumRepository curriculumRepo = Get.find();

  // Curriculum state
  Rx<Curriculum?> selectedCurriculum = Rx<Curriculum?>(null);
  final RxList<Curriculum?>? curriculumList = <Curriculum>[].obs;

  // Navbar selection
  final RxInt selectedNavIndex = 0.obs;
  final pagesList = [
    DashboardView(),
    const QuestionBankView(),
    const HistoryView(),
    Container(),
    Container(),
    Container(),
    Container()
  ];
  final navList = [
    "Dashboard",
    "Question Bank",
    // "Flash Cards",
    "History",
    "Exam Builder",
    "Store",
    // "Tutors",
    "FAQ"
  ];

  Widget get getCurrentPage => pagesList[selectedNavIndex.value];
  String get currentNavName => navList[selectedNavIndex.value];

  @override
  void onInit() {
    super.onInit();
    getUserCurriculum();
    getCurriculums();
  }

  Future<void> getUserCurriculum() async {
    selectedCurriculum.value = await localRepo.getCurriculum();
    // if (selectedCurriculum.value == null) {
    // Future.delayed(const Duration(seconds: 2), () {
    // showCurriculumDialog(dismissable: true);
    // });
    // }
  }

  Future<void> setUserCurriculum({Curriculum? value}) async {
    selectedCurriculum.value = value;
    await localRepo.setCurriculum(jsonEncode(value?.toJson()));
  }

  // Include get user

  // Include logout
  Future<void> logout() async {
    await authRepo.logout(onSuccess: (value) {
      clearSession();
    }, onError: (error) {
      clearSession();
    });
  }

  Future<void> getCurriculums() async {
    await curriculumRepo.getCurriculums(
        onSuccess: (value) {
          curriculumList?.value = value ?? [];
          if (selectedCurriculum.value == null) {
            setUserCurriculum(value: value?.first);
          }
        },
        onError: (error) {});
  }

  void showCurriculumDialog({bool dismissable = true}) {
    BaseDialog.customise(
        dismissable: dismissable,
        child: SelectionDialog(
          isMultiSelect: false,
          childRatio: 3,
          numberOfColumn: 2,
          title: "curriculum",
          selectionList: curriculumList
              ?.map((e) =>
                  KeyValue(label: e?.name, sublabel: e?.board, key: e?.id))
              .toList(),
          emitData: (data) {
            if (data?.isNotEmpty == true) {
              final filteredCurriculum = curriculumList?.firstWhereOrNull(
                  (element) => element?.id == data?.first.key);
              setUserCurriculum(value: filteredCurriculum);
            }
          },
        ));
  }

  void clearSession() {
    localRepo.clearStorage();
    Get.offAllNamed(Routes.login);
  }

  void onTerminateStopWatch({String? time}) {
    debugPrint("Last Time ${time}");
  }
}
