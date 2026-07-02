import "package:talker_flutter/talker_flutter.dart";

typedef TalkerSetup = void Function(Talker talker);

class TalkerFactory {
  const TalkerFactory({this.settings, this.setups = const []});

  final TalkerSettings? settings;
  final List<TalkerSetup> setups;

  Talker create() {
    final talker = TalkerFlutter.init(settings: settings ?? TalkerSettings());

    for (final setup in setups) {
      setup(talker);
    }

    talker.info("Talker initialized");

    return talker;
  }
}
