import 'package:edupals/core/base/model/key_value.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final menuList = [
    KeyValue(
        label: "User Setting", keyValueList: [KeyValue(label: "My Account")]),
    KeyValue(label: "Payment", keyValueList: [
      KeyValue(label: "Subscriptions"),
      KeyValue(label: "Referals Rewards"),
      KeyValue(label: "billing")
    ]),
    KeyValue(
        label: "App Setting", keyValueList: [KeyValue(label: "Notification")]),
    KeyValue(label: "Others", keyValueList: [
      KeyValue(label: "FAQ"),
      KeyValue(label: "Log Out"),
    ]),
  ];

  final Rx<KeyValue?> selectedMenu = Rx<KeyValue?>(null);

  void onSelectMenu({required KeyValue menu}) {
    selectedMenu.value = menu;
  }
}
