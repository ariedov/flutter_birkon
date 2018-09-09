abstract class LanguageUpdateEvent {

  factory LanguageUpdateEvent.started(int newLanguageCode) = LangaugeUpdateStarted;
  factory LanguageUpdateEvent.finished(int newLanguageCode) = LanguageUpdateFinished;
}

class LangaugeUpdateStarted implements LanguageUpdateEvent {
  final int newLanguageCode;
  const LangaugeUpdateStarted(this.newLanguageCode);
}

class LanguageUpdateFinished implements LanguageUpdateEvent {
  final int newLanguageCode;
  const LanguageUpdateFinished(this.newLanguageCode);
}

