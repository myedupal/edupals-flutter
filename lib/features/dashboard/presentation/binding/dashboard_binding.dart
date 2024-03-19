import 'package:edupals/features/dashboard/presentation/controller/dashborad_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // Register datasource
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
