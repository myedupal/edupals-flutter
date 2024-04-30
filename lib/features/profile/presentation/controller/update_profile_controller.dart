import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/base/model/user.dart';
import 'package:edupals/features/profile/domain/repository/user_account_repository.dart';
import 'package:edupals/features/profile/presentation/view/screens/account_view.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  final UserAccountRepository userAccountRepo = Get.find();
  final usernameController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();

  UpdateAccountType? updateType;

  void onSetUpdateType({UpdateAccountType? value}) {
    updateType = value;
  }

  void onSubmit() {
    updateType == UpdateAccountType.password
        ? updateUserPassword()
        : updateUserAcount();
  }

  void updateUserAcount() {
    final user = User(
      email: usernameController.text,
    );
    userAccountRepo.updateAccount(
        user: user, onSuccess: (value) {}, onError: (eror) {});
  }

  void updateUserPassword() {
    final userPassword = User(
        currentPassword: currentPasswordController.text,
        password: newPasswordController.text,
        passwordConfirmation: confirmPasswordController.text);
    userAccountRepo.updatePassword(
        user: userPassword,
        onSuccess: (value) {
          updateSuccess();
        },
        onError: (eror) {});
  }

  void updateSuccess() {
    BaseDialog.showSuccess(
      message: "You have successfully updated password !",
      action: () {
        Get.until((route) => Get.isDialogOpen == false);
      },
    );
  }
}
