import 'package:edupals/core/base/model/key_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectionDialogController extends GetxController {
  final RxList<KeyValue?>? selectedList = <KeyValue>[].obs;

  void selectData({KeyValue? value}) {
    final selectedDataIndex =
        selectedList?.indexWhere((element) => element?.key == value?.key);
    (selectedDataIndex == -1)
        ? selectedList?.add(value)
        : selectedList?.removeAt(selectedDataIndex ?? 0);
    debugPrint("${selectedList?.length}");
  }
}
