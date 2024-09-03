import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  Future<bool> load() async {
    // Add any additional loading logic if needed
    return true;
  }

  // Example of language name getters
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      locale: locale.toString(),
    );
  }

  String get afrikaans {
    return Intl.message(
      'Afrikaans',
      name: 'afrikaans',
      locale: locale.toString(),
    );
  }

  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      locale: locale.toString(),
    );
  }

  String get chinese {
    return Intl.message(
      'Chinese',
      name: 'chinese',
      locale: locale.toString(),
    );
  }

  String get dutch {
    return Intl.message(
      'Dutch',
      name: 'dutch',
      locale: locale.toString(),
    );
  }

  String get french {
    return Intl.message(
      'French',
      name: 'french',
      locale: locale.toString(),
    );
  }

  String get german {
    return Intl.message(
      'German',
      name: 'german',
      locale: locale.toString(),
    );
  }

  String get greek {
    return Intl.message(
      'Greek',
      name: 'greek',
      locale: locale.toString(),
    );
  }

  String get hebrew {
    return Intl.message(
      'Hebrew',
      name: 'hebrew',
      locale: locale.toString(),
    );
  }

  String get polish {
    return Intl.message(
      'Polish',
      name: 'polish',
      locale: locale.toString(),
    );
  }

  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      locale: locale.toString(),
    );
  }

  String get languageOption {
    return Intl.message(
      'Language',
      name: 'languageOption',
      locale: locale.toString(),
    );
  }

// Add other localized strings here
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'af', 'ar', 'zh', 'nl', 'fr', 'de', 'el', 'he', 'pl']
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
