import 'package:edupals/config/flavor_config.dart';
import 'package:edupals/core/base/base_binding.dart';
import 'package:edupals/core/routes/app_pages.dart';
import 'package:edupals/core/values/app_theme.dart';
import 'package:edupals/features/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void mainGlobal() async {
  setUrlStrategy(null);
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: FlavorConfig.fileName);
  await clearSecureStorageOnReinstall();
  runApp(const MyApp());
}

Future<void> clearSecureStorageOnReinstall() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  const FlutterSecureStorage secureStorageInstance = FlutterSecureStorage();
  final bool isRunBefore = prefs.getBool("hasRunBefore") ?? false;
  if (!isRunBefore) {
    await secureStorageInstance.deleteAll();
    await prefs.setBool("hasRunBefore", true);
  }
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
