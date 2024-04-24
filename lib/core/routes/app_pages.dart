import 'package:edupals/core/components/navbar.dart';
import 'package:edupals/features/auth/presentation/binding/auth_binding.dart';
import 'package:edupals/features/challenge/presentation/binding/challenge_details_binding.dart';
import 'package:edupals/features/challenge/presentation/binding/daily_challenge_binding.dart';
import 'package:edupals/features/challenge/presentation/view/screens/challenge_complete_view.dart';
import 'package:edupals/features/challenge/presentation/view/screens/challenge_details_view.dart';
import 'package:edupals/features/challenge/presentation/view/screens/daily_challenge_view.dart';
import 'package:edupals/features/dashboard/presentation/view/screens/dashboard_view.dart';
import 'package:edupals/features/exam-builder/presentation/binding/exam_builder_details_binding.dart';
import 'package:edupals/features/exam-builder/presentation/view/screens/exam_builder_details_view.dart';
import 'package:edupals/features/profile/presentation/view/screens/profile_view.dart';
import 'package:edupals/features/question-bank/presentation/binding/questions_list_binding.dart';
import 'package:edupals/features/question-bank/presentation/view/screens/questions_list_view.dart';
import 'package:edupals/features/splash/presentation/binding/splash_binding.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/features/auth/presentation/view/screens/auth_view.dart';
import 'package:edupals/features/splash/presentation/view/splash_view.dart';
import 'package:get/get.dart';

class AppPages {
  static const initial = Routes.main;

  static final routes = [
    GetPage(
        name: Routes.main,
        page: () => const SplashView(),
        binding: SplashBinding()),
    GetPage(name: Routes.home, page: () => const Navbar()),
    GetPage(name: Routes.dashboard, page: () => DashboardView()),
    GetPage(
        name: Routes.login,
        page: () => const AuthView(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.questionsList,
        page: () => const QuestionsListView(),
        binding: QuestionsListBinding()),
    GetPage(
        name: Routes.dailyChallenge,
        page: () => const DailyChallengeView(),
        binding: DailyChallengeBinding()),
    GetPage(
        name: Routes.challengeComplete, page: () => ChallengeCompleteView()),
    GetPage(
        name: "${Routes.challengeDetails}/:id",
        page: () => const ChallengeDetailsView(),
        binding: ChallengeDetailsBinding()),
    GetPage(
      name: Routes.examBuilderDetails,
      page: () => const ExamBuilderDetailsView(),
      binding: ExamBuilderDetailsBinding(),
    ),
    GetPage(
      name: Routes.profile,
      transition: Transition.circularReveal,
      fullscreenDialog: true,
      page: () => const ProfileView(),
    ),
  ];
}
