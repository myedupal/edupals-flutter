import 'package:edupals/features/dashboard/presentation/view/screens/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Global use controller
class MainController extends GetxController {
  final RxInt selectedNavIndex = 0.obs;
  final pagesList = [
    DashboardView(),
    DashboardView(),
    DashboardView(),
    DashboardView(),
    DashboardView(),
    DashboardView(),
    DashboardView(),
    DashboardView()
  ];
  final navList = [
    "Dashboard",
    "Question Bank",
    "Flash Cards",
    "History",
    "Exam Builder",
    "Store",
    "Tutors",
    "FAQ"
  ];

  Widget get getCurrentPage => pagesList[selectedNavIndex.value];

  // Include get user

  // Include logout
}
