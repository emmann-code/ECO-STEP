import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../../generated/l10n/app_localziations.dart';
import '../../../main.dart';

class ChangeLanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Moved languages definition inside build method where context is available
    final List<LanguageOption> languages = [
      LanguageOption(name: AppLocalizations.of(context)!.english, locale: Locale('en')),
      LanguageOption(name: AppLocalizations.of(context)!.afrikaans, locale: Locale('af')),
      LanguageOption(name: AppLocalizations.of(context)!.arabic, locale: Locale('ar')),
      LanguageOption(name: AppLocalizations.of(context)!.chinese, locale: Locale('zh')),
      LanguageOption(name: AppLocalizations.of(context)!.dutch, locale: Locale('nl')),
      LanguageOption(name: AppLocalizations.of(context)!.french, locale: Locale('fr')),
      LanguageOption(name: AppLocalizations.of(context)!.german, locale: Locale('de')),
      LanguageOption(name: AppLocalizations.of(context)!.greek, locale: Locale('el')),
      LanguageOption(name: AppLocalizations.of(context)!.hebrew, locale: Locale('he')),
      LanguageOption(name: AppLocalizations.of(context)!.polish, locale: Locale('pl')),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(AppLocalizations.of(context)!.changeLanguage),
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.language, color: Colors.blue),
            title: Text(languages[index].name),
            trailing: MyApp.of(context)?.locale.languageCode == languages[index].locale.languageCode
                ? Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              _changeLanguage(context, languages[index].locale);
            },
          );
        },
      ),
    );
  }

  void _changeLanguage(BuildContext context, Locale locale) {
    final currentLocale = MyApp.of(context)?.locale;
    if (currentLocale?.languageCode != locale.languageCode) {
      print('Changing language to: ${locale.languageCode}');
      MyApp.of(context)?.setLocale(locale);

      // Popping back to the previous page or refreshing UI
      Navigator.of(context).pop();
    }
  }
}

class LanguageOption {
  final String name;
  final Locale locale;

  LanguageOption({required this.name, required this.locale});
}
