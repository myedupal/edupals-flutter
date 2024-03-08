import 'package:flutter/material.dart';

class KeyValue {
  KeyValue(
      {this.label,
      this.sublabel,
      this.id,
      this.date,
      this.type,
      this.key,
      this.displayInfo,
      this.isEmpty = false,
      this.isAction = false,
      this.logo,
      this.errorMessage,
      this.percentage,
      this.globalKey,
      this.widget,
      this.isDestroy,
      this.description,
      this.price,
      this.additionalData,
      this.isBase64,
      this.onAction,
      this.isFilterAction = false,
      this.color});

  String? id;
  String? date;
  String? type;
  String? displayInfo;
  bool? isEmpty = false;
  bool? isAction = false;
  String? label;
  String? sublabel;
  String? logo;
  String? key;
  String? errorMessage;
  double? percentage;
  GlobalKey? globalKey = GlobalKey();
  Widget? widget;
  bool? isDestroy = false;
  String? description;
  String? price;
  dynamic additionalData;
  bool? isBase64 = false;
  VoidCallback? onAction;
  bool? isFilterAction = false;
  Color? color;
}
