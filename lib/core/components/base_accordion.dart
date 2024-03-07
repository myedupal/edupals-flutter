import 'package:edupals/core/base/base_divider.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';

class BaseAccordion extends StatefulWidget {
  const BaseAccordion({
    super.key,
    this.title,
    this.sideTitle,
    this.subtitle,
    this.child,
    this.trailingWidget,
    this.isRounded = false,
    this.showHighlight = true,
  });

  final String? sideTitle;
  final String? title;
  final String? subtitle;
  final Widget? child;
  final Widget Function(bool isExpanded)? trailingWidget;
  final bool isRounded;
  final bool showHighlight;

  @override
  State<BaseAccordion> createState() => _BaseAccordionState();
}

class _BaseAccordionState extends State<BaseAccordion> {
  bool _showChild = true;
  double turns = 0;

  void _changeRotation() {
    setState(() => turns = turns == -0.25 ? 0.0 : -0.25);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Row(
                children: [
                  if (widget.sideTitle?.isEmpty == false)
                    Text(
                      widget.sideTitle ?? "",
                      style: MyTextStyle.xxs.bold.c(AppColors.accent500),
                    ).capsulise(
                        radius: 100,
                        color: AppColors.accent100,
                        padding: const EdgeInsets.symmetric(
                            vertical: AppValues.double2,
                            horizontal: AppValues.double10)),
                  Flexible(
                      child: Text(
                    widget.title ?? "",
                    style: MyTextStyle.xs.bold,
                  ).padding(const EdgeInsets.symmetric(
                          horizontal: AppValues.double20))),
                ],
              )),
              AnimatedRotation(
                  turns: turns,
                  duration: const Duration(milliseconds: 100),
                  child: const ImageAssetView(
                    fileName: AppAssets.downChevron,
                    width: AppValues.double10,
                  )),
            ],
          ),
        ).padding(const EdgeInsets.symmetric(vertical: 10)).onTap(() {
          setState(() {
            _changeRotation();
            _showChild = !_showChild;
          });
        }),
        AnimatedSize(
            alignment: Alignment.topCenter,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Column(
              children: [
                const BaseDivider(),
                if (_showChild) widget.child ?? Container()
              ],
            ))
      ],
    );
  }
}
