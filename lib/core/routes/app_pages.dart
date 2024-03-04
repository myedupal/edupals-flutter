import 'package:edupals/core/components/navbar.dart';
import 'package:edupals/features/challenge/presentation/view/screens/daily_challenge_view.dart';
import 'package:edupals/features/dashboard/presentation/view/screens/dashboard_view.dart';
import 'package:edupals/features/question-bank/presentation/view/screens/questions_list_view.dart';
import 'package:edupals/features/splash/presentation/binding/splash_binding.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/features/auth/login_view.dart';
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
    GetPage(name: Routes.login, page: () => const LoginView()),
    GetPage(name: Routes.questionsList, page: () => const QuestionsListView()),
    GetPage(
        name: Routes.dailyChallenge, page: () => const DailyChallengeView()),
  ];
}
