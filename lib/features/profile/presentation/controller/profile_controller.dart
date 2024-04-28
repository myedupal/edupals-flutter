import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/base/model/key_value.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final MainController mainController = Get.find();
  final menuList = [
    KeyValue(
        label: "User Setting", keyValueList: [KeyValue(label: "My Account")]),
    KeyValue(label: "Payment", keyValueList: [
      KeyValue(label: "Subscriptions"),
      KeyValue(label: "Referals Rewards"),
      KeyValue(label: "Billing")
    ]),
    KeyValue(
        label: "App Setting", keyValueList: [KeyValue(label: "Notification")]),
    KeyValue(label: "Others", keyValueList: [
      KeyValue(label: "FAQ"),
      KeyValue(label: "Log Out", key: "logout"),
    ]),
  ];

  final Rx<KeyValue?> selectedMenu = Rx<KeyValue?>(null);

  @override
  void onInit() {
    onSelectMenu(menu: menuList.first.keyValueList?.first);
    super.onInit();
  }

  void onSelectMenu({KeyValue? menu}) {
    if (menu?.key == "logout") {
      logout();
      return;
    }
    selectedMenu.value = menu;
  }

  void logout() {
    BaseDialog.showError(
      title: "Logout",
      subtitle: "Are you sure to logout?",
      buttonText: "Yes, I insist",
      action: () {
        mainController.logout();
        Get.back();
      },
    );
  }
}
