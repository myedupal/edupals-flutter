import 'package:edupals/core/base/base_button.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/features/splash/presentation/controller/zkp_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZkpView extends GetView<ZkpViewController> {
  const ZkpView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ZkpViewController());
    return Column(
      children: [
        Text("ZKProof"),
        BaseButton(
            text: "Get ZKProof",
            onClick: () {
              controller.getZkProof();
            })
      ],
    ).scaffoldWrapper();
  }
}
