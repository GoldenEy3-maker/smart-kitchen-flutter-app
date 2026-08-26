import "dart:math" as math;

import "package:flutter/rendering.dart";
import "package:flutter/widgets.dart";

class AppBottomNavigationBarParentData
    extends ContainerBoxParentData<RenderBox> {}

/// Lays out nav items by their actual sizes.
///
/// The selected item stays at content width; leftover space is split among
/// inactive items. During a tab change, leftover flex is lerped so slots do
/// not jump when the label mounts or unmounts.
class AppBottomNavigationBarLayout extends MultiChildRenderObjectWidget {
  const AppBottomNavigationBarLayout({
    required super.children,
    required this.spacing,
    required this.selectedIndex,
    required this.previousIndex,
    required this.indicatorProgress,
    required this.indicatorColor,
    required this.indicatorRadius,
    super.key,
  });

  final double spacing;
  final int selectedIndex;
  final int previousIndex;
  final Animation<double> indicatorProgress;
  final Color indicatorColor;
  final double indicatorRadius;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderAppBottomNavigationBarLayout(
      spacing: spacing,
      selectedIndex: selectedIndex,
      previousIndex: previousIndex,
      indicatorProgress: indicatorProgress,
      indicatorColor: indicatorColor,
      indicatorRadius: indicatorRadius,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderAppBottomNavigationBarLayout renderObject,
  ) {
    renderObject
      ..spacing = spacing
      ..selectedIndex = selectedIndex
      ..previousIndex = previousIndex
      ..indicatorProgress = indicatorProgress
      ..indicatorColor = indicatorColor
      ..indicatorRadius = indicatorRadius;
  }
}

class RenderAppBottomNavigationBarLayout extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, AppBottomNavigationBarParentData>,
        RenderBoxContainerDefaultsMixin<
          RenderBox,
          AppBottomNavigationBarParentData
        > {
  RenderAppBottomNavigationBarLayout({
    required this._spacing,
    required this._selectedIndex,
    required this._previousIndex,
    required this._indicatorProgress,
    required this._indicatorColor,
    required this._indicatorRadius,
  });

  double _spacing;
  double get spacing => _spacing;
  set spacing(double value) {
    if (_spacing == value) {
      return;
    }
    _spacing = value;
    markNeedsLayout();
  }

  int _selectedIndex;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int value) {
    if (_selectedIndex == value) {
      return;
    }
    _selectedIndex = value;
    markNeedsLayout();
  }

  int _previousIndex;
  int get previousIndex => _previousIndex;
  set previousIndex(int value) {
    if (_previousIndex == value) {
      return;
    }
    _previousIndex = value;
    markNeedsLayout();
  }

  Animation<double> _indicatorProgress;
  Animation<double> get indicatorProgress => _indicatorProgress;
  set indicatorProgress(Animation<double> value) {
    if (identical(_indicatorProgress, value)) {
      return;
    }
    if (attached) {
      _indicatorProgress.removeListener(_handleIndicatorTick);
      value.addListener(_handleIndicatorTick);
    }
    _indicatorProgress = value;
    markNeedsLayout();
  }

  void _handleIndicatorTick() {
    markNeedsLayout();
  }

  Color _indicatorColor;
  Color get indicatorColor => _indicatorColor;
  set indicatorColor(Color value) {
    if (_indicatorColor == value) {
      return;
    }
    _indicatorColor = value;
    markNeedsPaint();
  }

  double _indicatorRadius;
  double get indicatorRadius => _indicatorRadius;
  set indicatorRadius(double value) {
    if (_indicatorRadius == value) {
      return;
    }
    _indicatorRadius = value;
    markNeedsPaint();
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _indicatorProgress.addListener(_handleIndicatorTick);
  }

  @override
  void detach() {
    _indicatorProgress.removeListener(_handleIndicatorTick);
    super.detach();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! AppBottomNavigationBarParentData) {
      child.parentData = AppBottomNavigationBarParentData();
    }
  }

  @override
  void performLayout() {
    final count = childCount;
    final height = constraints.maxHeight;
    final maxWidth = constraints.maxWidth;

    if (count == 0) {
      size = constraints.constrain(Size(maxWidth, height));
      return;
    }

    final available = math.max(0.0, maxWidth - _spacing * (count - 1));
    final preferred = <double>[];
    final mins = <double>[];

    var child = firstChild;
    while (child != null) {
      child.layout(
        BoxConstraints(
          maxWidth: available,
          minHeight: height,
          maxHeight: height,
        ),
        parentUsesSize: true,
      );
      preferred.add(child.size.width);
      mins.add(
        child.getMinIntrinsicWidth(height).clamp(0.0, child.size.width),
      );
      child = childAfter(child);
    }

    final allocated = _allocate(
      available: available,
      preferred: preferred,
      mins: mins,
      selectedIndex: _selectedIndex,
      previousIndex: _previousIndex,
      progress: _indicatorProgress.value,
    );

    var x = 0.0;
    var index = 0;
    child = firstChild;
    while (child != null) {
      child.layout(
        BoxConstraints.tightFor(width: allocated[index], height: height),
        parentUsesSize: true,
      );
      (child.parentData! as AppBottomNavigationBarParentData).offset = Offset(
        x,
        (height - child.size.height) / 2,
      );
      x += allocated[index] + _spacing;
      child = childAfter(child);
      index++;
    }

    size = constraints.constrain(Size(maxWidth, height));
  }

  static List<double> _allocate({
    required double available,
    required List<double> preferred,
    required List<double> mins,
    required int selectedIndex,
    required int previousIndex,
    required double progress,
  }) {
    final count = preferred.length;
    if (count == 0) {
      return const [];
    }

    if (count == 1) {
      return [preferred[0].clamp(mins[0], available)];
    }

    final preferredSum = preferred.fold<double>(0, (sum, width) => sum + width);
    final leftover = available - preferredSum;

    if (leftover < 0) {
      final minSum = mins.fold<double>(0, (sum, width) => sum + width);
      if (minSum >= available) {
        if (minSum <= 0) {
          return List<double>.filled(count, 0);
        }
        final scale = available / minSum;
        return [for (final min in mins) min * scale];
      }
      final extra = available - minSum;
      final wants = [
        for (var i = 0; i < count; i++) math.max(0.0, preferred[i] - mins[i]),
      ];
      final wantSum = wants.fold<double>(0, (sum, width) => sum + width);
      if (wantSum <= 0) {
        final scale = available / minSum;
        return [for (final min in mins) min * scale];
      }
      return [
        for (var i = 0; i < count; i++) mins[i] + extra * wants[i] / wantSum,
      ];
    }

    final flexes = [
      for (var i = 0; i < count; i++)
        _leftoverFlex(
          index: i,
          previousIndex: previousIndex,
          selectedIndex: selectedIndex,
          progress: progress,
        ),
    ];
    final flexSum = flexes.fold<double>(0, (sum, flex) => sum + flex);
    if (flexSum <= 0) {
      return List<double>.of(preferred);
    }

    return [
      for (var i = 0; i < count; i++)
        preferred[i] + leftover * flexes[i] / flexSum,
    ];
  }

  /// 0 keeps the item at content width; 1 lets it absorb leftover space.
  /// Lerps so the outgoing tab does not snap to an inactive slot.
  static double _leftoverFlex({
    required int index,
    required int previousIndex,
    required int selectedIndex,
    required double progress,
  }) {
    final from = index == previousIndex ? 0.0 : 1.0;
    final to = index == selectedIndex ? 0.0 : 1.0;
    return from + (to - from) * progress;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final indicatorRect = _indicatorRect;
    if (indicatorRect != null) {
      final paint = Paint()..color = _indicatorColor;
      context.canvas.drawRRect(
        RRect.fromRectAndRadius(
          indicatorRect.shift(offset),
          Radius.circular(_indicatorRadius),
        ),
        paint,
      );
    }
    defaultPaint(context, offset);
  }

  Rect? get _indicatorRect {
    final selectedRect = _rectForIndex(_selectedIndex);
    if (selectedRect == null) {
      return null;
    }
    final progress = _indicatorProgress.value;
    if (progress >= 1 || _previousIndex == _selectedIndex) {
      return selectedRect;
    }
    final previousRect = _rectForIndex(_previousIndex);
    if (previousRect == null) {
      return selectedRect;
    }
    return Rect.lerp(previousRect, selectedRect, progress);
  }

  Rect? _rectForIndex(int index) {
    if (index < 0) {
      return null;
    }
    var i = 0;
    var child = firstChild;
    while (child != null) {
      if (i == index) {
        final parentData =
            child.parentData! as AppBottomNavigationBarParentData;
        return parentData.offset & child.size;
      }
      child = childAfter(child);
      i++;
    }
    return null;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return _intrinsicWidth(height, (child, height) {
      return child.getMinIntrinsicWidth(height);
    });
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return _intrinsicWidth(height, (child, height) {
      return child.getMaxIntrinsicWidth(height);
    });
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return _maxChildIntrinsicHeight(width, (child, width) {
      return child.getMinIntrinsicHeight(width);
    });
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return _maxChildIntrinsicHeight(width, (child, width) {
      return child.getMaxIntrinsicHeight(width);
    });
  }

  double _intrinsicWidth(
    double height,
    double Function(RenderBox child, double height) childWidth,
  ) {
    var width = 0.0;
    var child = firstChild;
    var index = 0;
    while (child != null) {
      if (index > 0) {
        width += _spacing;
      }
      width += childWidth(child, height);
      child = childAfter(child);
      index++;
    }
    return width;
  }

  double _maxChildIntrinsicHeight(
    double width,
    double Function(RenderBox child, double width) childHeight,
  ) {
    var maxHeight = 0.0;
    var child = firstChild;
    while (child != null) {
      maxHeight = math.max(maxHeight, childHeight(child, width));
      child = childAfter(child);
    }
    return maxHeight;
  }
}
