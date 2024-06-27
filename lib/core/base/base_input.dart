import 'dart:async';

import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum KeyboardType { text, number, password, textarea, tap }

class BaseInput extends StatefulWidget {
  const BaseInput({
    super.key,
    this.value,
    this.label,
    this.required = false,
    this.errorMessage = "",
    this.enabled = true,
    this.isUppercase = false,
    this.keyboardType = KeyboardType.text,
    this.inputFormatters,
    this.onClick,
    this.onValueChange,
    this.textStyle = MyTextStyle.s,
    this.controller,
    this.labelStyle = MyTextStyle.s,
    this.maxLength,
  });

  final bool required;
  final String? label;
  final String? value;
  final String errorMessage;
  final bool enabled;
  final bool isUppercase;
  final KeyboardType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onClick;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextEditingController? controller;
  final Function(String)? onValueChange;
  final int? maxLength;

  @override
  State<BaseInput> createState() => _BaseInputState();
}

class _BaseInputState extends State<BaseInput> {
  final FocusNode _focusNode = FocusNode();
  // final widget.controller? = TextEditingController();
  Color _borderColor = AppColors.gray400;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      if (widget.value != null) {
        widget.controller?.text = widget.value ?? "";
      }
    });
    _focusNode.addListener(() {
      setState(() {
        _borderColor =
            _focusNode.hasFocus ? AppColors.accent500 : AppColors.gray400;
      });
    });
  }

  @override
  void didUpdateWidget(covariant BaseInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      Future.delayed(Duration.zero, () async {
        widget.controller?.text = widget.value ?? "";
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  TextInputType _keyboardType() {
    switch (widget.keyboardType) {
      case KeyboardType.text:
        return TextInputType.visiblePassword;
      case KeyboardType.number:
        return TextInputType.number;
      case KeyboardType.textarea:
        return TextInputType.multiline;
      default:
        return TextInputType.visiblePassword;
    }
  }

  void _toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Widget? get _getIcon {
    if (widget.keyboardType == KeyboardType.password) {
      return Icon(
        _showPassword ? Icons.visibility : Icons.visibility_off,
        size: AppValues.double20,
      ).onTap(() {
        _toggleShowPassword();
      });
    } else if (widget.controller?.text.isNotEmpty == true) {
      return const Icon(
        Icons.clear,
        size: AppValues.double20,
      ).onTap(
        () {
          widget.controller?.clear();
        },
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(
              AppValues.double12,
              AppValues.double8,
              _getIcon != null ? AppValues.double6 : AppValues.double12,
              AppValues.double14),
          decoration: BoxDecoration(
            border: Border.all(color: _borderColor),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.label?.isNotEmpty == true) ...[
                Row(
                  children: [
                    Text(
                      widget.label ?? "",
                      style: MyTextStyle.xs.h(2).c(_focusNode.hasFocus
                          ? AppColors.accent500
                          : AppColors.gray600),
                    ),
                    if (widget.required)
                      Text(
                        "*",
                        style: MyTextStyle.xs.copyWith(color: AppColors.red600),
                      ),
                  ],
                )
              ],
              TextField(
                focusNode: _focusNode,
                onTapOutside: (event) {
                  _focusNode.unfocus();
                },
                maxLength: widget.maxLength,
                inputFormatters: widget.inputFormatters,
                obscureText: widget.keyboardType == KeyboardType.password &&
                    !_showPassword,
                keyboardType: _keyboardType(),
                enabled: widget.enabled,
                controller: widget.controller,
                style: widget.textStyle,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  prefixIcon: null,
                  suffixIconConstraints: const BoxConstraints(minWidth: 30),
                  suffixIcon: _getIcon,
                ),
              )
            ],
          ),
        ),
        if (widget.errorMessage.isNotEmpty)
          Text(
            "* ${widget.errorMessage}",
            style: MyTextStyle.s.c(AppColors.red600),
          ).padding(const EdgeInsets.only(
              left: AppValues.double18, top: AppValues.double12))
      ],
    );
  }
}
