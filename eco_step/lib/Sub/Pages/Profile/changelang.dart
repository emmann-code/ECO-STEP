// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:intl/intl.dart';
//
// import '../../../main.dart';
//
// class ChangeLanguagePage extends StatelessWidget {
//   final List<LanguageOption> languages = [
//     LanguageOption(name: 'English', locale: Locale('en')),
//     LanguageOption(name: 'Africans', locale: Locale('af')),
//     LanguageOption(name: 'Arabic', locale: Locale('ar')),
//     LanguageOption(name: 'Chinese', locale: Locale('zh')),
//     LanguageOption(name: 'Dutch', locale: Locale('nl')),
//     LanguageOption(name: 'French', locale: Locale('fr')),
//     LanguageOption(name: 'German', locale: Locale('de')),
//     LanguageOption(name: 'Greek', locale: Locale('el')),
//     LanguageOption(name: 'Hebrew', locale: Locale('he')),
//     LanguageOption(name: 'Polish', locale: Locale('pl')),
//     // Add other languages here
//   ];
//
//   void _changeLanguage(BuildContext context, Locale locale) {
//     Locale myLocale = Localizations.localeOf(context);
//     if (locale != myLocale) {
//       MyApp.of(context)?.setLocale(locale);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Change Language'),
//       ),
//       body: ListView.builder(
//         itemCount: languages.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             leading: Icon(Icons.language, color: Colors.blue),
//             title: Text(languages[index].name),
//             trailing: MyApp.of(context)?.locale == languages[index].locale
//                 ? Icon(Icons.check, color: Colors.green)
//                 : null,
//             onTap: () {
//               _changeLanguage(context, languages[index].locale);
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
//
// class LanguageOption {
//   final String name;
//   final Locale locale;
//
//   LanguageOption({required this.name, required this.locale});
// }
import 'package:flutter/material.dart';
class ChangeLanguagePage extends StatelessWidget {
  const ChangeLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.red,);
  }
}
