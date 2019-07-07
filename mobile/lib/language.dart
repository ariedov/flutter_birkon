abstract class LanguageUpdateEvent {

  factory LanguageUpdateEvent.started(int newLanguageCode) = LangaugeUpdateStarted;
  factory LanguageUpdateEvent.finished(int newLanguageCode) = LanguageUpdateFinished;
  factory LanguageUpdateEvent.requried(double headerHeight) = LanguageUpdateRequired;
}

class LanguageUpdateRequired implements LanguageUpdateEvent {
  final double headerHeight;
  const LanguageUpdateRequired(this.headerHeight);
}

class LangaugeUpdateStarted implements LanguageUpdateEvent {
  final int newLanguageCode;
  const LangaugeUpdateStarted(this.newLanguageCode);
}

class LanguageUpdateFinished implements LanguageUpdateEvent {
  final int newLanguageCode;
  const LanguageUpdateFinished(this.newLanguageCode);
}

