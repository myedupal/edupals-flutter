import 'dart:convert';
import 'package:edupals/config/flavor_config.dart';
import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/base/base_snackbar.dart';
import 'package:edupals/core/base/model/key_value.dart';
import 'package:edupals/core/base/model/user.dart';
import 'package:edupals/core/base/model/user_key.dart';
import 'package:edupals/core/base/sui_helper.dart';
import 'package:edupals/core/repositories/local_repository.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/features/auth/domain/repository/auth_repository.dart';
import 'package:edupals/features/dashboard/domain/model/curriculum.dart';
import 'package:edupals/features/dashboard/domain/repository/curriculum_repository.dart';
import 'package:edupals/features/dashboard/presentation/view/screens/dashboard_view.dart';
import 'package:edupals/features/explore/presentation/view/screen/explore_view.dart';
import 'package:edupals/features/history/domain/model/activity.dart';
import 'package:edupals/features/history/domain/repository/activity_repository.dart';
import 'package:edupals/features/history/presentation/controller/history_controller.dart';
import 'package:edupals/features/mcq/presentation/view/screen/mcq_view.dart';
import 'package:edupals/features/mcq/presentation/view/screen/topical_mcq_view.dart';
import 'package:edupals/features/profile/domain/repository/user_account_repository.dart';
import 'package:edupals/features/profile/presentation/view/components/update_profile_form.dart';
import 'package:edupals/features/profile/presentation/view/screens/account_view.dart';
import 'package:edupals/features/question-bank/presentation/view/components/selection_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sui/sui_account.dart';
import 'package:sui/sui_client.dart';
import 'package:sui/sui_urls.dart';

// Global use controller
class MainController extends GetxController {
  final AuthRepository authRepo = Get.find();
  final UserAccountRepository userAccountRepo = Get.find();
  final LocalRepository localRepo = Get.find();
  final CurriculumRepository curriculumRepo = Get.find();
  final ActivityRepository activityRepo = Get.find();
  RxBool isFirstTimeLogin = false.obs;
  RxBool isFinishSetUser = false.obs;

  // Sui core state
  final suiClient =
      SuiClient(FlavorConfig.isProduction ? SuiUrls.mainnet : SuiUrls.devnet);
  UserKey? userKey = UserKey();
  SuiAccount? suiAccount;
  String? jwt;
  String? userSalt;
  String? suiAddress;

  // Curriculum state
  Rx<Curriculum?> selectedCurriculum = Rx<Curriculum?>(null);
  Rx<User?> currentUser = Rx<User?>(null);
  final RxList<Curriculum?>? curriculumList = <Curriculum>[].obs;

  // Navbar selection
  final RxInt selectedNavIndex = 0.obs;
  final pagesList = [
    const DashboardView(),
    const ExploreView(),
    const MCQView(),
    const TopicalMcqView(),
    // const QuestionBankView(),
    // const HistoryView(),
    // const ExamBuilderView(),
    // Container(),
    // Container(),
    // Container()
  ];
  final navList = [
    "Dashboard",
    "Explore",
    "MCQ",
    "Topical MCQs",
    // "Question Bank",
    // "Flash Cards",
    // "History",
    // "Exam Builder",
    // "Store",
    // "Tutors",
    // "FAQ"
  ];

  Widget get getCurrentPage => pagesList[selectedNavIndex.value];
  String get currentNavName => navList[selectedNavIndex.value];
  String get googleLoginUrl =>
      'https://accounts.google.com/o/oauth2/v2/auth/oauthchooseaccount?'
      'client_id=${FlavorConfig.googleClientId}&response_type=id_token'
      '&redirect_uri=${kIsWeb ? Uri.encodeComponent(FlavorConfig.redirectUrl) : FlavorConfig.redirectUrl}'
      '&scope=openid+https://www.googleapis.com/auth/userinfo.profile+https://www.googleapis.com/auth/userinfo.email'
      '&nonce=${userKey?.nonce}'
      '&service=lso&o2v=2&theme=mn&ddm=0&flowName=GeneralOAuthFlow'
      '&id_token=$jwt';

  @override
  void onInit() {
    super.onInit();
    refreshUser();
    getUserKeyData();
  }

  void goAhead() {
    getCurriculums();
    if (!isFirstTimeLogin.value) {
      getUser();
    }
  }

  void onSetNavIndex(int index) {
    selectedNavIndex.value = index;
  }

  Future<void> setUserCurriculum({Curriculum? value}) async {
    selectedCurriculum.value = value;
    // await localRepo.setCurriculum(jsonEncode(value?.toJson()));
    // Call Api selected_curriculum_id
    updateUserAccount();
  }

  Future<void> getCurriculums() async {
    await curriculumRepo.getCurriculums(
        onSuccess: (value) {
          curriculumList?.value = value ?? [];
          if (!isFirstTimeLogin.value &&
              currentUser.value != null &&
              isFinishSetUser.value) {
            checkValidCurriculum();
          }
        },
        onError: (error) {});
  }

  void showCurriculumDialog({bool dismissable = true}) {
    BaseDialog.customise(
        dismissable: dismissable,
        child: SelectionDialog(
          isMultiSelect: false,
          childRatio: 3,
          numberOfColumn: 2,
          title: "curriculum",
          selectionList: curriculumList
              ?.map((e) =>
                  KeyValue(label: e?.name, sublabel: e?.board, key: e?.id))
              .toList(),
          emitData: (data) {
            if (data?.isNotEmpty == true) {
              final filteredCurriculum = curriculumList?.firstWhereOrNull(
                  (element) => element?.id == data?.first.key);
              setUserCurriculum(value: filteredCurriculum);
            }
          },
        ));
  }

  // Set user and token state
  void refreshUser() async {
    final user = await localRepo.getUser();
    currentUser.value = user;
    selectedCurriculum.value = user?.selectedCurriculum;
    jwt = await localRepo.getUserIdToken();
    userSalt = await localRepo.getUserSalt();
    if (jwt?.isEmpty == false && userSalt?.isEmpty == false) {
      onSetSuiAddress();
    }
  }

  void getUser() async {
    await userAccountRepo.getAccount(
        onSuccess: (value) {
          setUser(user: value);
        },
        onError: (error) {});
  }

  void setUser(
      {User? user, String? salt, bool isFirstTimeLogin = false}) async {
    this.isFirstTimeLogin.value = isFirstTimeLogin;
    currentUser.value = user;
    selectedCurriculum.value = user?.selectedCurriculum;
    await localRepo.setUser(jsonEncode(user?.toStore()));
    if (salt?.isEmpty == false) {
      userSalt = salt;
      await localRepo.setUserSalt(salt);
    }
    if (isFirstTimeLogin && user?.phoneNumber == null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        BaseDialog.customise(
          dismissable: false,
          child: const UpdateProfileForm(
              updateType: UpdateAccountType.firstTimeLogin),
        );
      });
    } else {
      checkValidCurriculum();
    }
    isFinishSetUser.value = true;
    refreshUser();
  }

  void checkValidCurriculum() {
    if (currentUser.value?.selectedCurriculum == null) {
      if (curriculumList?.isNotEmpty == true && Get.isDialogOpen == false) {
        selectedCurriculum.value = null;
        showCurriculumDialog(dismissable: false);
      }
    }
  }

  void setJwtToken({required String token}) async {
    jwt = token;
    await localRepo.setUserIdToken(token);
  }

  void updateUserAccount() {
    final user = User(
      selectedCurriculumId: selectedCurriculum.value?.id,
    );
    userAccountRepo.updateAccount(
        user: user,
        onSuccess: (value) {
          currentUser.value = value;
        },
        onError: (error) {
          BaseSnackBar.show(message: "Error: $error");
        });
  }

  // Include logout
  Future<void> logout() async {
    await authRepo.logout(onSuccess: (value) {
      clearSession();
    }, onError: (error) {
      clearSession();
    });
  }

  void clearSession() {
    currentUser.value == null;
    isFinishSetUser.value = false;
    localRepo.clearStorage();
    Get.offAllNamed(Routes.loginAnimation);
  }

  Future<void> onTerminateStopWatch({int? time, String? activityId}) async {
    final HistoryController historyController = Get.find();
    await activityRepo.updateActivity(
        activity: Activity(recordedTime: time),
        id: activityId ?? "",
        onSuccess: (value) {},
        onError: (error) {});
    historyController.refreshHistory();
  }
}
