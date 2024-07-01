import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/base/base_snackbar.dart';
import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/base/model/user.dart';
import 'package:edupals/features/profile/domain/repository/user_account_repository.dart';
import 'package:edupals/features/profile/presentation/view/screens/account_view.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UpdateProfileController extends BaseController {
  final UserAccountRepository userAccountRepo = Get.find();
  final MainController mainController = Get.find();
  final usernameController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();

  UpdateAccountType? updateType;

  @override
  void onInit() {
    usernameController.text = mainController.currentUser.value?.name ?? "";
    phoneNumberController.text =
        mainController.currentUser.value?.phoneNumber ?? "";
    super.onInit();
  }

  void onSetUpdateType({UpdateAccountType? value}) {
    updateType = value;
  }

  void onSubmit() {
    updateType == UpdateAccountType.password
        ? updateUserPassword()
        : updateUserAcount();
  }

  void updateUserAcount() {
    setLoading();
    final user = User(
      name: usernameController.text,
      phoneNumber: phoneNumberController.text,
    );
    userAccountRepo.updateAccount(
        user: user,
        onSuccess: (value) {
          setSuccess();
          updateSuccess(value: value);
        },
        onError: (error) {
          setSuccess();
          BaseSnackBar.show(message: error.message);
        });
  }

  void updateUserPassword() {
    setLoading();
    final userPassword = User(
        currentPassword: currentPasswordController.text,
        password: newPasswordController.text,
        passwordConfirmation: confirmPasswordController.text);
    userAccountRepo.updatePassword(
        user: userPassword,
        onSuccess: (value) {
          setSuccess();
          updateSuccess(value: value);
        },
        onError: (error) {
          setSuccess();
          BaseSnackBar.show(message: error.message);
        });
  }

  void updateSuccess({User? value}) {
    mainController.setUser(user: value);
    BaseDialog.showSuccess(
      dismissable: false,
      message:
          "You have successfully updated ${updateType?.displayTitle?.toLowerCase()}!",
      action: () {
        Get.until((route) => Get.isDialogOpen == false);
        if (updateType == UpdateAccountType.firstTimeLogin) {
          mainController.checkValidCurriculum();
        }
      },
    );
  }
}
