import 'package:edupals/config/flavor_config.dart';
import 'package:edupals/core/base/base_binding.dart';
import 'package:edupals/core/routes/app_pages.dart';
import 'package:edupals/core/values/app_theme.dart';
import 'package:edupals/features/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void mainGlobal() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: FlavorConfig.fileName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      initialBinding: BaseBinding(),
      theme: AppTheme().appTheme(),
      home: const SplashView(),
    );
  }
}
