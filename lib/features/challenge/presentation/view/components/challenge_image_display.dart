import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/presentation/view/components/image_viewer.dart';
import 'package:flutter/widgets.dart';

class ChallengeImageDisplay extends StatelessWidget {
  const ChallengeImageDisplay({super.key, this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ImageAssetView(
      fileName: imageUrl ?? "",
    )
        .padding(const EdgeInsets.symmetric(vertical: AppValues.double30))
        .onTap(() {
      BaseDialog.customise(
          isBase: true,
          child: ImageViewer(
            imageUrl: imageUrl,
          ));
    });
  }
}
