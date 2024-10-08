import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPicturePreview extends StatefulWidget {
  const ChatPicturePreview({
    super.key,
    this.currentIndex = 0,
    this.images = const [],
    this.heroTag,
    this.onTap,
    this.onLongPress,
  });

  final int currentIndex;
  final List<String> images;
  final String? heroTag;
  final Function()? onTap;
  final Function(String url)? onLongPress;

  @override
  ChatPicturePreviewState createState() => ChatPicturePreviewState();
}

class ChatPicturePreviewState extends State<ChatPicturePreview> {
  late final ExtendedPageController? controller;

  @override
  void initState() {
    super.initState();
    controller = widget.images.length > 1
        ? ExtendedPageController(
            initialPage: widget.currentIndex, pageSpacing: 50)
        : null;
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final systemPadding = MediaQuery.of(context).padding;
    return Padding(
      padding: systemPadding,
      child: ExtendedImageSlidePage(
        slideAxis: SlideAxis.vertical,
        slidePageBackgroundHandler: (offset, pageSize) =>
            defaultSlidePageBackgroundHandler(
          color: Colors.black,
          offset: offset,
          pageSize: pageSize,
        ),
        child: MetaHero(
          heroTag: widget.heroTag,
          onTap: widget.onTap ?? () => Get.back(),
          onLongPress: () {
            final index = controller?.page?.round() ?? 0;
            widget.onLongPress?.call(widget.images[index]);
          },
          child: _childView,
        ),
      ),
    );
  }

  Widget get _childView {
    return widget.images.length == 1
        ? _networkGestureImage(widget.images[0])
        : _pageView;
  }

  Widget get _pageView => ExtendedImageGesturePageView.builder(
        controller: controller,
        onPageChanged: (int index) {},
        itemCount: widget.images.length,
        itemBuilder: (BuildContext context, int index) {
          return _networkGestureImage(widget.images.elementAt(index));
        },
      );

  Widget _networkGestureImage(String url) => ExtendedImage.network(
        url,
        fit: BoxFit.contain,
        mode: ExtendedImageMode.gesture,
        clearMemoryCacheWhenDispose: true,
        clearMemoryCacheIfFailed: true,
        handleLoadingProgress: true,
        enableSlideOutPage: false,
        onDoubleTap: (ExtendedImageGestureState state) async {},
        initGestureConfigHandler: (ExtendedImageState state) {
          return GestureConfig(
            minScale: 1,
            animationMinScale: 1,
            inPageView: true,
            initialScale: 1.0,
            maxScale: 5.0,
            animationMaxScale: 6.0,
            speed: 1,
            inertialSpeed: 600.0,
            initialAlignment: InitialAlignment.center,
          );
        },
        loadStateChanged: (ExtendedImageState state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              {
                final ImageChunkEvent? loadingProgress = state.loadingProgress;
                final double? progress =
                    loadingProgress?.expectedTotalBytes != null
                        ? loadingProgress!.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null;

                return SizedBox(
                  width: 15.0,
                  height: 15.0,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: const Color(0xffE8B339),
                      strokeWidth: 1.5,
                      value: progress ?? 0,
                    ),
                  ),
                );
              }
            case LoadState.completed:
              return null;
            case LoadState.failed:
              state.imageProvider.evict();
              return null;
          }
        },
      );
}

class MetaHero extends StatelessWidget {
  const MetaHero({
    Key? key,
    required this.heroTag,
    required this.child,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);
  final Widget child;
  final String? heroTag;
  final Function()? onTap;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    final view = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      onLongPress: onLongPress,
      child: child,
    );
    return heroTag == null ? view : Hero(tag: heroTag!, child: view);
  }
}
