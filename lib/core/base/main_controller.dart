import 'dart:convert';
import 'package:edupals/config/flavor_config.dart';
import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/base/model/key_value.dart';
import 'package:edupals/core/base/model/user.dart';
import 'package:edupals/core/base/model/user_key.dart';
import 'package:edupals/core/repositories/local_repository.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/features/auth/domain/repository/auth_repository.dart';
import 'package:edupals/features/dashboard/domain/model/curriculum.dart';
import 'package:edupals/features/dashboard/domain/repository/curriculum_repository.dart';
import 'package:edupals/features/dashboard/presentation/view/screens/dashboard_view.dart';
import 'package:edupals/features/exam-builder/presentation/view/screens/exam_builder_view.dart';
import 'package:edupals/features/history/domain/model/activity.dart';
import 'package:edupals/features/history/domain/repository/activity_repository.dart';
import 'package:edupals/features/history/presentation/controller/history_controller.dart';
import 'package:edupals/features/history/presentation/view/screens/history_view.dart';
import 'package:edupals/features/profile/domain/repository/user_account_repository.dart';
import 'package:edupals/features/question-bank/presentation/view/components/selection_dialog.dart';
import 'package:edupals/features/question-bank/presentation/view/screens/question_bank_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sui/cryptography/ed25519_keypair.dart';
import 'package:sui/sui_account.dart';
import 'package:sui/sui_client.dart';
import 'package:sui/sui_urls.dart';
import 'package:zklogin/zklogin.dart';

// Global use controller
class MainController extends GetxController {
  final AuthRepository authRepo = Get.find();
  final UserAccountRepository userAccountRepo = Get.find();
  final LocalRepository localRepo = Get.find();
  final CurriculumRepository curriculumRepo = Get.find();
  final ActivityRepository activityRepo = Get.find();

  // Sui core state
  final suiClient = SuiClient(SuiUrls.devnet);
  UserKey? userKey = UserKey();
  SuiAccount? suiAccount;
  String? jwt;

  // Curriculum state
  Rx<Curriculum?> selectedCurriculum = Rx<Curriculum?>(null);
  Rx<User?> currentUser = Rx<User?>(null);
  final RxList<Curriculum?>? curriculumList = <Curriculum>[].obs;

  // Navbar selection
  final RxInt selectedNavIndex = 0.obs;
  final pagesList = [
    DashboardView(),
    const QuestionBankView(),
    const HistoryView(),
    const ExamBuilderView(),
    Container(),
    Container(),
    Container()
  ];
  final navList = [
    "Dashboard",
    "Question Bank",
    // "Flash Cards",
    "History",
    "Exam Builder",
    "Store",
    // "Tutors",
    "FAQ"
  ];

  Widget get getCurrentPage => pagesList[selectedNavIndex.value];
  String get currentNavName => navList[selectedNavIndex.value];

  @override
  void onInit() {
    super.onInit();
    refreshUser();
    getUserCurriculum();
    getCurriculums();
    getUserKeyData();
  }

  String get googleLoginUrl =>
      'https://accounts.google.com/o/oauth2/v2/auth/oauthchooseaccount?'
      'client_id=${FlavorConfig.googleClientId}&response_type=id_token'
      '&redirect_uri=${kIsWeb ? Uri.encodeComponent(FlavorConfig.redirectUrl) : FlavorConfig.redirectUrl}'
      '&scope=openid+https://www.googleapis.com/auth/userinfo.profile+https://www.googleapis.com/auth/userinfo.email'
      '&nonce=${userKey?.nonce}'
      '&service=lso&o2v=2&theme=mn&ddm=0&flowName=GeneralOAuthFlow'
      '&id_token=$jwt';

  void getUserKeyData() async {
    final UserKey? userKeyData = await localRepo.getUserKeyData();
    if (userKeyData != null) {
      userKey = userKeyData;
      suiAccount = SuiAccount.fromPrivKey(
        userKeyData.privateKey ?? "",
      );
    } else {
      prepareLogin();
    }
  }

  void prepareLogin() async {
    // Create Ephemeral Account
    suiAccount = SuiAccount(Ed25519Keypair());
    final result = await suiClient.getLatestSuiSystemState();
    // Create Sui max epoch
    userKey?.maxEpoch = int.parse(result.epoch) + 10;
    userKey?.publicKey = suiAccount?.keyPair.getPublicKey().toBase64();
    userKey?.privateKey = suiAccount?.privateKey();
    // Create randomness
    userKey?.randomness = generateRandomness();
    // Create nonce
    userKey?.nonce = generateNonce(suiAccount!.keyPair.getPublicKey(),
        userKey?.maxEpoch ?? 0, userKey?.randomness ?? "");
    debugPrint("My user key ${userKey?.privateKey}");
    await localRepo.setUserKeyData(jsonEncode(userKey));
  }

  void onSetNavIndex(int index) {
    selectedNavIndex.value = index;
  }

  Future<void> getUserCurriculum() async {
    selectedCurriculum.value = await localRepo.getCurriculum();
    // if (selectedCurriculum.value == null) {
    // Future.delayed(const Duration(seconds: 2), () {
    // showCurriculumDialog(dismissable: true);
    // });
    // }
  }

  Future<void> setUserCurriculum({Curriculum? value}) async {
    selectedCurriculum.value = value;
    await localRepo.setCurriculum(jsonEncode(value?.toJson()));
  }

  // Include get user

  // Include logout
  Future<void> logout() async {
    await authRepo.logout(onSuccess: (value) {
      clearSession();
    }, onError: (error) {
      clearSession();
    });
  }

  Future<void> getCurriculums() async {
    await curriculumRepo.getCurriculums(
        onSuccess: (value) {
          curriculumList?.value = value ?? [];
          if (selectedCurriculum.value == null) {
            setUserCurriculum(value: value?.first);
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

  void refreshUser() async {
    currentUser.value = await localRepo.getUser();
  }

  void setUser({User? user}) async {
    currentUser.value = user;
    await localRepo.setUser(jsonEncode(user));
    refreshUser();
  }

  void getUser() async {
    await userAccountRepo.getAccount(
        onSuccess: (value) {
          setUser(user: value);
        },
        onError: (error) {});
  }

  void clearSession() {
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
