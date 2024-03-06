import 'package:edupals/core/repositories/local_repository.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/features/auth/domain/repository/auth_repository.dart';
import 'package:edupals/features/dashboard/presentation/view/screens/dashboard_view.dart';
import 'package:edupals/features/history/presentation/view/screens/history_view.dart';
import 'package:edupals/features/question-bank/presentation/view/screens/question_bank_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Global use controller
class MainController extends GetxController {
  final AuthRepository authRepo = Get.find();
  final LocalRepository localRepo = Get.find();
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

  // Include get user

  // Include logout
  Future<void> logout() async {
    await authRepo.logout(
        onSuccess: (value) {
          localRepo.clearStorage();
          Get.offAllNamed(Routes.login);
        },
        onError: (error) {});
  }
}
