import 'dart:async';

import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum KeyboardType { text, number, password, textarea, tap }

class BaseInput extends StatefulWidget {
  const BaseInput(
      {super.key,
      this.value,
      this.label,
      this.errorMessage = "",
      this.enabled = true,
      this.isUppercase = false,
      this.keyboardType = KeyboardType.text,
      this.inputFormatters,
      this.onClick,
      this.onValueChange,
      this.textStyle = MyTextStyle.body1,
      this.labelStyle = MyTextStyle.body1});

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
  final Function(String)? onValueChange;

  @override
  State<BaseInput> createState() => _BaseInputState();
}

class _BaseInputState extends State<BaseInput> {
  final FocusNode _focusNode = FocusNode();
  final _controller = TextEditingController();
  Color _borderColor = AppColors.gray600;
  bool _showPassword = false;
  Timer? _checkTypingTimer;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      if (widget.value != null) {
        _controller.text = widget.value ?? "";
      }
    });
    _controller.addListener(_printLatestValue);
    _focusNode.addListener(() {
      setState(() {
        _borderColor =
            _focusNode.hasFocus ? AppColors.accent500 : AppColors.gray600;
      });
    });
  }

  void _printLatestValue() {
    Future.delayed(Duration.zero, () async {
      resetTimer();
    });
  }

  startTimer() {
    _checkTypingTimer = Timer(const Duration(milliseconds: 500), () {
      widget.onValueChange?.call(_controller.text);
    });
  }

  resetTimer() {
    _checkTypingTimer?.cancel();
    startTimer();
  }

  @override
  void didUpdateWidget(covariant BaseInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      Future.delayed(Duration.zero, () async {
        _controller.text = widget.value ?? "";
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppValues.double12),
          decoration: BoxDecoration(
            border: Border.all(color: _borderColor),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.label?.isNotEmpty == true)
                Text(
                  widget.label ?? "",
                  style: MyTextStyle.body1.c(_focusNode.hasFocus
                      ? AppColors.accent500
                      : AppColors.gray600),
                ),
              TextField(
                focusNode: _focusNode,
                onTapOutside: (event) {
                  _focusNode.unfocus();
                },
                inputFormatters: widget.inputFormatters,
                obscureText: widget.keyboardType == KeyboardType.password &&
                    !_showPassword,
                keyboardType: _keyboardType(),
                enabled: widget.enabled,
                controller: _controller,
                style: widget.textStyle,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  prefixIcon: null,
                ),
              )
            ],
          ),
        ),
        if (widget.errorMessage.isNotEmpty)
          Text(
            "* ${widget.errorMessage}",
            style: MyTextStyle.body1.c(AppColors.red600),
          ).padding(const EdgeInsets.only(
              left: AppValues.double18, top: AppValues.double12))
      ],
    );
  }
}
