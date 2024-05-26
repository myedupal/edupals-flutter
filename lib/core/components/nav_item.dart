import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  const NavItem({super.key, this.name, this.isActive = false});

  final String? name;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppValues.double60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(
                horizontal: isActive ? AppValues.double15 : 0,
                vertical: AppValues.double6),
            decoration: BoxDecoration(
                color: isActive ? AppColors.accent100 : AppColors.white,
                borderRadius: const BorderRadius.all(Radius.circular(100))),
            child: ImageAssetView(
                height: AppValues.double18,
                color: isActive ? AppColors.accent500 : AppColors.gray900,
                fileName: AppAssets().getSvgPath(
                    name: name?.replaceAll(" ", "_").toLowerCase() ?? "")),
          ),
          Text(
            name ?? "",
            style: isActive
                ? MyTextStyle.xxs.bold.h(0).c(AppColors.accent500)
                : MyTextStyle.xxs.medium.h(0),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
