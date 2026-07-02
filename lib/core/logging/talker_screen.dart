import "package:flutter/material.dart";
import "package:talker_flutter/talker_flutter.dart";

class CustomTalkerScreen extends StatelessWidget {
  final Talker talker;

  const CustomTalkerScreen({super.key, required this.talker});

  @override
  Widget build(BuildContext context) {
    return TalkerScreen(talker: talker, isLogsExpanded: false);
  }
}
