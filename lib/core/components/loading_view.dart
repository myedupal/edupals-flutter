import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/context_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageAssetView(
            fileName: (!(kIsWeb && context.isPhone))
                ? AppAssets.questionLoadingLottie
                : AppAssets.questionLoadingStatic,
            width: Get.dynamicWidth * 0.3,
          ),
          Text(
            "We are preparing the best for you...",
            style: MyTextStyle.l.bold,
          )
        ],
      ),
    ));
  }
}
