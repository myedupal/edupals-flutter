import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';

class BaseHorizontalBarChart extends StatelessWidget {
  const BaseHorizontalBarChart({
    super.key,
    this.dylabels = const ["18-24", "25-34", "35-44", "45-54", "55-64"],
    this.dxlabels = const [
      0,
      100,
      200,
      400,
      500,
    ],
    this.data = const [30, 50, 100, 200, 300],
    this.leftRatio,
    this.rightRatio,
  });

  final List<String>? dylabels;
  final List<int>? dxlabels;
  final List<double>? data;
  final double? leftRatio;
  final double? rightRatio;

  double get columnTopPadding {
    return 20;
  }

  double get columnBottomPadding {
    return 20;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double parentWidth = constraints.maxWidth;
      double leftWidth = parentWidth * (leftRatio ?? 0.25);
      double rightWidth = parentWidth * (rightRatio ?? 0.75);
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: leftWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var i = 0; i < (dylabels?.length ?? 0); i++)
                  Padding(
                    padding: EdgeInsets.only(
                      top: columnTopPadding,
                    ),
                    child: Text(
                      dylabels?[i] ?? "",
                      textAlign: TextAlign.end,
                      style: MyTextStyle.xxs.bold.c(AppColors.white),
                    ),
                  ),
              ],
            ).padding(const EdgeInsets.only(right: 10)),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: SizedBox(
                          width: rightWidth + 10,
                          child: Row(
                            children: [
                              for (var i = 0;
                                  i < (dxlabels?.length ?? 0);
                                  i++) ...[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Container(
                                            width: 0.15,
                                            color: AppColors.white),
                                      ],
                                    )),
                                    Text(
                                      "${dxlabels?[i] ?? 0}",
                                      style: MyTextStyle.xxs.c(AppColors.white),
                                    ).padding(const EdgeInsets.only(top: 5))
                                  ],
                                ),
                                if (i != (dxlabels?.length ?? 0) - 1)
                                  const Spacer()
                              ]
                            ],
                          ),
                        ))
                      ]),
                ),
                Column(
                  children: [
                    for (var i = 0; i < (dylabels?.length ?? 0); i++)
                      Padding(
                        padding: EdgeInsets.only(
                          top: columnTopPadding,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: ((data?[i] ?? 0) / (dxlabels?.last ?? 0)) *
                                  rightWidth,
                              height: AppValues.double25,
                              decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            ),
                            Text(
                              "${data?[i].ceil() ?? 0}",
                              style: MyTextStyle.xxs.c(AppColors.white),
                            ).padding(const EdgeInsets.only(left: 5))
                          ],
                        ),
                      ),
                  ],
                ).padding(
                    EdgeInsets.only(bottom: columnBottomPadding, left: 1)),
              ],
            ),
          )
        ],
      );
    });
  }
}
