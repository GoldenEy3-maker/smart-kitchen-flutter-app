import "package:flutter/material.dart";
import "package:talker_flutter/talker_flutter.dart";

class CustomTalkerScreen extends StatelessWidget {
  const CustomTalkerScreen({required this.talker, super.key});
  final Talker talker;

  @override
  Widget build(BuildContext context) {
    return TalkerScreen(talker: talker, isLogsExpanded: false);
  }
}
