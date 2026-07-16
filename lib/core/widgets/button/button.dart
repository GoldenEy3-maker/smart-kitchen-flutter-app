import "package:flutter/material.dart";

class ButtonThemeData {
  final Color backgroundColor;
  final Color foregroundColor;
  final BorderRadius borderRadius;

  ButtonThemeData({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderRadius,
  });
}

class Button extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const Button({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Ink(child: child),
      ),
    );
  }
}

class PrimaryButton extends Button {
  const PrimaryButton({
    super.key,
    required super.child,
    required super.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Button(onPressed: onPressed, child: child);
  }
}
