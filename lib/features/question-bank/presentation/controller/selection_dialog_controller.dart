import 'package:edupals/core/base/model/key_value.dart';
import 'package:get/get.dart';

class SelectionDialogController extends GetxController {
  RxList<KeyValue>? selectedList = <KeyValue>[].obs;

  void selectData({required KeyValue value, bool isMultiSelect = true}) {
    final selectedDataIndex =
        selectedList?.indexWhere((element) => element.key == value.key);
    (selectedDataIndex == -1)
        ? {
            if (!isMultiSelect && (selectedList?.isEmpty == false))
              selectedList?.value = [],
            selectedList?.add(value)
          }
        : selectedList?.removeAt(selectedDataIndex ?? 0);
  }
}
