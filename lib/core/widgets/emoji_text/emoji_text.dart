import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

class EmojiText extends StatelessWidget {
  final String emoji;
  final TextStyle? style;

  const EmojiText({
    super.key,
    required this.emoji,
    this.style = const TextStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return Text(emoji, style: style?.copyWith(fontFamily: AppFonts.notoEmoji));
  }
}
