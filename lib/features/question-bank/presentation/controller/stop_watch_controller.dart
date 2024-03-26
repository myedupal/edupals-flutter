import 'dart:async';

import 'package:edupals/core/base/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin StopWatchHelper on GetxController {
  final MainController controller = Get.find();
  Stopwatch stopwatch = Stopwatch();
  bool isRunning = false;
  late Timer _timer;
  RxString formattedTime = '00:00:00'.obs;

  @override
  void onClose() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
      _timer.cancel(); // Stop the timer when the page is closed
      controller.onTerminateStopWatch(time: formattedTime.value);
    }
    super.onClose();
  }

  void startStopwatch() {
    stopwatch.start();
    isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      formattedTime.value = stopwatch.elapsed.toString().split('.')[0];
      debugPrint("$formattedTime");
    });
  }

  String? stopStopwatch() {
    stopwatch.stop();
    isRunning = false;
    _timer.cancel();
    return formattedTime.value;
  }

  void resetStopwatch() {
    stopwatch.reset();
    formattedTime.value = '00:00:00';
    isRunning = false;
  }
}
