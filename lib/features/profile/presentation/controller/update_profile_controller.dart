import 'package:edupals/core/base/model/key_value.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  final usernameController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();

  KeyValue? updateType;

  void onSetUpdateType({KeyValue? value}) {
    updateType = value;
  }

  void onSubmit() {}
}
