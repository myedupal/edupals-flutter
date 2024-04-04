import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({super.key, this.imageUrl});

  final String? imageUrl;

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  final TransformationController _transformationController =
      TransformationController();
  final GlobalKey _childKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      centerChild();
    });
  }

  void centerChild() {
    const double scale = 0.8;
    if (_childKey.currentContext != null) {
      final RenderBox renderBox =
          _childKey.currentContext!.findRenderObject()! as RenderBox;
      final Size childSize = renderBox.size;
      final Offset center = Offset((childSize.width / 2) * (scale - 0.05),
          (childSize.height / 2) * scale);
      final Offset viewCenter = Offset(Get.width / 2, Get.height / 2);
      final Offset offset = viewCenter - center;
      final Matrix4 matrix = Matrix4.identity()
        ..scale(scale)
        ..translate(offset.dx, offset.dy);
      _transformationController.value = matrix;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
        transformationController: _transformationController,
        boundaryMargin: const EdgeInsets.all(300),
        scaleEnabled: true,
        child: ImageAssetView(
          key: _childKey,
          fileName: widget.imageUrl ?? "",
        )).onTap(() {
      Get.back();
    });
  }
}
