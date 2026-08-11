import "package:flutter/widgets.dart";

/* 
* Prevents [TextField] focus from scrolling the viewport to top.
* See https://github.com/flutter/flutter/issues/25507 
 */
class NoImplicitScrollPhysics extends ScrollPhysics {
  const NoImplicitScrollPhysics({super.parent});

  @override
  NoImplicitScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return NoImplicitScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  bool get allowImplicitScrolling => false;
}
