import 'package:edupals/config/flavor_config.dart';
import 'package:edupals/core/enum/view_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edupals/core/network/errors/failures.dart';
import 'package:logger/logger.dart';

abstract class BaseController extends GetxController {
  final Logger logger = FlavorConfig.instance.logger;

  //Controls page state
  final Rx<ViewState> _pageSateController = ViewState.initial.obs;

  ViewState get viewState => _pageSateController.value;

  bool get isLoading => viewState == ViewState.loading;

  ViewState updateViewState(ViewState state) => _pageSateController(state);

  ViewState setLoading() => updateViewState(ViewState.loading);

  ViewState setSuccess() => updateViewState(ViewState.success);

  ViewState setNoData() => updateViewState(ViewState.noData);

  // ViewState setError() => updateViewState(ViewState.error);

  ViewState setNoInternet() => updateViewState(ViewState.noInternet);

  void showErrorMessage(String msg) {
    // showErrorSnackBar(msg);
  }

  // Use this method when you have more than one ViewState in a controller
  // this will help to different from the main ViewState used for say API calling
  void setRxViewState(Rx<ViewState> rxViewState, ViewState value) {
    if (value != rxViewState.value) {
      rxViewState.value = value;
    }
  }

  bool _isHomeIndicatorVisible() {
    final bool isHomeIndicatorVisibleiOS =
        MediaQuery.of(Get.context!).size.width == 375 &&
            MediaQuery.of(Get.context!).size.height == 667;

    return isHomeIndicatorVisibleiOS || GetPlatform.isAndroid;
  }

  bool get isHomeIndicatorVisible => _isHomeIndicatorVisible();

  ViewState setError(BaseFailure f) {
    logger.e('!!! Base Controller error: ${f.detailedMessage} !!!');

    // if (f is NoInternetConnectionFailure) {
    // showErrorMessage(f.detailedMessage.tr);
    // } else {
    showErrorMessage(f.detailedMessage);
    // }

    return updateViewState(ViewState.error);
  }
}
