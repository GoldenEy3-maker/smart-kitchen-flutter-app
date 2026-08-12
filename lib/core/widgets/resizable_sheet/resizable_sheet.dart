import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

typedef ResizableSheetBuilder =
    Widget Function(
      BuildContext context,
      ScrollController scrollController,
      DraggableScrollableController sheetController,
    );

class ResizableSheet extends StatefulWidget {
  const ResizableSheet({
    super.key,
    this.initialSize,
    required this.maxSize,
    this.snap = true,
    required this.builder,
    this.fitMaxSizeToContent = false,
    this.fitToContent = false,
  }) : assert(
         initialSize != null || fitToContent,
         "initialSize is required unless fitToContent is true",
       ),
       assert(
         !fitToContent || !fitMaxSizeToContent,
         "Use either fitToContent or fitMaxSizeToContent, not both",
       );

  /// Opening size as a fraction of the available height.
  ///
  /// Optional when [fitToContent] is true — the sheet measures content and
  /// opens at that height (capped by [maxSize]).
  final double? initialSize;

  /// Upper bound for the sheet size as a fraction of the available height.
  final double maxSize;

  final bool snap;

  final ResizableSheetBuilder builder;

  /// Caps [maxSize] at the height needed by scrollable content, so the sheet
  /// cannot be expanded into empty space. Keep using an explicit [initialSize].
  ///
  /// Requires the builder to attach [scrollController] to a vertical scrollable.
  final bool fitMaxSizeToContent;

  /// Measures intrinsically-sized content and sets both the opening size and
  /// max size to that height (capped by [maxSize]).
  ///
  /// Use for short sheets (confirm/create). Content must have an intrinsic
  /// height (e.g. [Column], shrink-wrapped lists) — not an expanding
  /// [ListView].
  final bool fitToContent;

  @override
  State<ResizableSheet> createState() => _ResizableSheetState();
}

class _ResizableSheetState extends State<ResizableSheet> {
  static const _bootstrapSize = 0.05;

  final DraggableScrollableController _controller =
      DraggableScrollableController();

  late double _effectiveMaxSize = widget.maxSize;
  double? _fittedSize;
  bool _hasMeasuredContent = false;

  /// After [fitMaxSizeToContent] settles, ignore further metrics. Resizing the
  /// sheet during a drag fires ScrollMetricsNotifications; setState there
  /// fights [DraggableScrollableSheet.snap] and the sheet jumps back.
  bool _fitMaxSizeLocked = false;
  double? _lastFittedMaxSize;

  double get _resolvedInitialSize =>
      widget.initialSize ?? _fittedSize ?? _bootstrapSize;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onContentHeight(double contentHeight) {
    if (!widget.fitToContent ||
        !_controller.isAttached ||
        _controller.size <= 0) {
      return;
    }

    final availableHeight = _controller.pixels / _controller.size;
    if (availableHeight <= 0) {
      return;
    }

    final newSize = (contentHeight / availableHeight).clamp(
      _bootstrapSize,
      widget.maxSize,
    );

    final sizeChanged =
        _fittedSize == null || (newSize - _fittedSize!).abs() > 0.001;
    if (!sizeChanged && _hasMeasuredContent) {
      return;
    }

    setState(() {
      _fittedSize = newSize;
      _effectiveMaxSize = newSize;
      _hasMeasuredContent = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_controller.isAttached) {
        return;
      }
      _controller.jumpTo(newSize);
    });
  }

  /// Caps the sheet's max size at the size that fits the scroll content
  /// exactly, so expanding the sheet never leaves empty space below it.
  ///
  /// At any moment the sheet height needed to fit everything equals
  /// `current sheet height + maxScrollExtent`: the invariant holds no matter
  /// how much non-scrollable content (header, buttons) surrounds the scroll
  /// view, because that content's height is the same at any sheet size.
  bool _onScrollMetrics(ScrollMetricsNotification notification) {
    if (!widget.fitMaxSizeToContent || _fitMaxSizeLocked) {
      return false;
    }

    final metrics = notification.metrics;
    if (metrics.axis != Axis.vertical ||
        !metrics.hasContentDimensions ||
        !_controller.isAttached ||
        _controller.size <= 0) {
      return false;
    }

    final minSize = widget.initialSize ?? _bootstrapSize;
    // Dismiss drag shrinks the sheet below the opening snap; each pixel
    // changes the list viewport and re-emits metrics. Rebuilding with snap
    // mid-gesture pulls the sheet back to snapSizes.
    if (_controller.size < minSize - 0.002) {
      return false;
    }

    final availableHeight = _controller.pixels / _controller.size;
    final contentFitSize =
        (_controller.pixels + metrics.maxScrollExtent) / availableHeight;
    final newMaxSize = contentFitSize.clamp(minSize, widget.maxSize);

    if ((newMaxSize - _effectiveMaxSize).abs() > 0.001) {
      setState(() {
        _effectiveMaxSize = newMaxSize;
      });
    }

    if (_lastFittedMaxSize != null &&
        (newMaxSize - _lastFittedMaxSize!).abs() <= 0.001) {
      _fitMaxSizeLocked = true;
    }
    _lastFittedMaxSize = newMaxSize;

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    final initialSize = widget.fitToContent
        ? (_fittedSize ?? _resolvedInitialSize)
        : _resolvedInitialSize;
    final maxSize = widget.fitToContent
        ? (_fittedSize ?? widget.maxSize)
        : widget.fitMaxSizeToContent
        ? _effectiveMaxSize
        : widget.maxSize;
    final snapSize = widget.fitToContent
        ? (_fittedSize ?? initialSize)
        : _resolvedInitialSize;

    return Opacity(
      opacity: !widget.fitToContent || _hasMeasuredContent ? 1 : 0,
      child: DraggableScrollableSheet(
        controller: _controller,
        expand: false,
        initialChildSize: initialSize.clamp(0.0, maxSize),
        maxChildSize: maxSize,
        minChildSize: 0,
        snap: widget.snap,
        snapSizes: widget.snap ? [snapSize.clamp(0.0, maxSize)] : null,
        builder: (context, scrollController) {
          // showModalBottomSheet(useSafeArea: true) zeroes MediaQuery.padding,
          // so a plain SafeArea would skip the home indicator. Keep viewPadding.
          final content = SafeArea(
            maintainBottomViewPadding: false,
            minimum: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 26,
            ),
            child: widget.builder(context, scrollController, _controller),
          );

          return Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              widget.fitToContent
                  ? _SheetContentMeasurer(
                      onMeasured: _onContentHeight,
                      child: content,
                    )
                  : NotificationListener<ScrollMetricsNotification>(
                      onNotification: _onScrollMetrics,
                      child: content,
                    ),
              Positioned(
                top: -20,
                child: Container(
                  width: 60,
                  height: 7,
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Measures [child]'s intrinsic height, then lays it out with the real sheet
/// constraints so nested scrollables can scroll when content exceeds [maxSize].
class _SheetContentMeasurer extends SingleChildRenderObjectWidget {
  const _SheetContentMeasurer({required this.onMeasured, required super.child});

  final ValueChanged<double> onMeasured;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSheetContentMeasurer(onMeasured: onMeasured);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderSheetContentMeasurer renderObject,
  ) {
    renderObject.onMeasured = onMeasured;
  }
}

class _RenderSheetContentMeasurer extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  _RenderSheetContentMeasurer({required this.onMeasured});

  ValueChanged<double> onMeasured;
  double? _lastReportedHeight;

  @override
  void performLayout() {
    final child = this.child;
    if (child == null) {
      size = constraints.biggest;
      return;
    }

    // Pass 1: intrinsic height with unbounded max height.
    child.layout(
      BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        minHeight: 0,
        maxHeight: double.infinity,
      ),
      parentUsesSize: true,
    );

    final intrinsicHeight = child.size.height;
    if (_lastReportedHeight == null ||
        (intrinsicHeight - _lastReportedHeight!).abs() > 0.5) {
      _lastReportedHeight = intrinsicHeight;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onMeasured(intrinsicHeight);
      });
    }

    // Pass 2: real sheet constraints so ScrollViews get a bounded viewport.
    // Without this, the child keeps an infinite max height and never scrolls.
    child.layout(constraints, parentUsesSize: true);
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = this.child;
    if (child != null) {
      context.paintChild(child, offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final child = this.child;
    return child?.hitTest(result, position: position) ?? false;
  }
}
