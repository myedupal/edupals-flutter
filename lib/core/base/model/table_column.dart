import 'package:flutter/material.dart';

class TableColumn<T> {
  TableColumn({
    this.name,
    this.selector,
    this.column,
    this.expanded = false,
    this.columnColor,
    this.icon,
    this.ableSort = false,
  });

  String? name;
  String? selector;
  Color? columnColor;
  bool ableSort;
  bool expanded;
  String? icon;
  Widget Function(T data, int index)? column;
}

abstract class TableConvertible {
  Map<String, dynamic> toTable();
}
