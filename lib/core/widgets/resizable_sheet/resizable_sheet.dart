import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

typedef ResizableSheetBuilder = Widget Function(BuildContext, ScrollController);

class ResizableSheet extends StatefulWidget {
  const ResizableSheet({
    super.key,
    required this.initialSize,
    required this.maxSize,
    required this.snap,
    required this.builder,
    this.fitMaxSizeToContent = false,
  });

  final double initialSize;

  final double maxSize;

  final bool snap;

  final ResizableSheetBuilder builder;

  final bool fitMaxSizeToContent;

  @override
  State<ResizableSheet> createState() => _ResizableSheetState();
}

class _ResizableSheetState extends State<ResizableSheet> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();

  late double _effectiveMaxSize = widget.maxSize;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Caps the sheet's max size at the size that fits the scroll content
  /// exactly, so expanding the sheet never leaves empty space below it.
  ///
  /// At any moment the sheet height needed to fit everything equals
  /// `current sheet height + maxScrollExtent`: the invariant holds no matter
  /// how much non-scrollable content (header, buttons) surrounds the scroll
  /// view, because that content's height is the same at any sheet size.
  bool _onScrollMetrics(ScrollMetricsNotification notification) {
    if (!widget.fitMaxSizeToContent) {
      return false;
    }

    final metrics = notification.metrics;
    if (metrics.axis != Axis.vertical ||
        !metrics.hasContentDimensions ||
        !_controller.isAttached ||
        _controller.size <= 0) {
      return false;
    }

    final availableHeight = _controller.pixels / _controller.size;
    final contentFitSize =
        (_controller.pixels + metrics.maxScrollExtent) / availableHeight;
    final newMaxSize = contentFitSize.clamp(widget.initialSize, widget.maxSize);

    if ((newMaxSize - _effectiveMaxSize).abs() > 0.001) {
      setState(() {
        _effectiveMaxSize = newMaxSize;
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _controller,
      expand: false,
      initialChildSize: widget.initialSize,
      maxChildSize: widget.fitMaxSizeToContent
          ? _effectiveMaxSize
          : widget.maxSize,
      minChildSize: 0,
      snap: widget.snap,
      snapSizes: widget.snap ? [widget.initialSize] : null,
      builder: (context, scrollController) => SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            NotificationListener<ScrollMetricsNotification>(
              onNotification: _onScrollMetrics,
              child: widget.builder(context, scrollController),
            ),
            Positioned(
              top: -20,
              child: Container(
                width: 60,
                height: 7,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
