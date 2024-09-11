import 'package:eco_step/Sub/Notifications/FirebaseNotifiApi.dart';
import 'package:eco_step/Sub/Notifications/notification_page.dart';
import 'package:eco_step/Sub/Pages/Education/initaialedu_page.dart';
import 'package:eco_step/Sub/Pages/MainScreen.dart';
import 'package:eco_step/Sub/Pages/Profile/profile.dart';
import 'package:eco_step/Sub/Pages/Scan/scan_page.dart';
import 'package:eco_step/Sub/Pages/Scan/testscan.dart';
import 'package:eco_step/Sub/SignIn&Up/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Sub/Components/my_splash.dart';
import 'Sub/Pages/Map/initialmap_page.dart';
import 'Sub/Services/auth/login_or_register.dart';
import 'Sub/Splah&Onboarding/onboarding_screens.dart';
import 'Sub/Splah&Onboarding/splash_screen.dart';
import 'Sub/Themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';


// Localization Imports
import 'generated/l10n/app_localziations.dart';
final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseNotifiApi().initNotifications();
  final notifications = <Map<String, String>>[];
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(notifications: notifications),
    ),
  );
}



class MyApp extends StatefulWidget {
  final List<Map<String, String>> notifications;
  MyApp({Key? key, required this.notifications}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en'); // Default locale

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  Locale get locale => _locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ECO-STEP',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      locale: _locale,
      supportedLocales: [
        Locale('en', ''), // English
        Locale('af', ''), // Afrikaans
        Locale('ar', ''), // Arabic
        Locale('zh', ''), // Chinese
        Locale('nl', ''), // Dutch
        Locale('fr', ''), // French
        Locale('de', ''), // German
        Locale('el', ''), // Greek
        Locale('he', ''), // Hebrew
        Locale('pl', ''), // Polish
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      // home: FirebaseNotifiApi(),
      home: OnboardingScreen(),
      // home: MainScreen(),
      // initialRoute: '/onboard',
      navigatorKey: navigatorKey,
      routes: {
        '/notifi': (context) => NotificationsPage(notifications: []),
        '/edu': (context) => EducationScreen(),
        '/main': (context) => MainScreen(),
        '/onboard': (context) => OnboardingScreen(),
        '/login': (context) => LoginOrRegister(),
      },
    );
  }
}
// import 'package:eco_step/Sub/Notifications/FirebaseNotifiApi.dart';
// import 'package:eco_step/Sub/Notifications/notification_page.dart';
// import 'package:eco_step/Sub/Pages/Education/initaialedu_page.dart';
// import 'package:eco_step/Sub/Pages/MainScreen.dart';
// import 'package:eco_step/Sub/Pages/Profile/profile.dart';
// import 'package:eco_step/Sub/Pages/Scan/scan_page.dart';
// import 'package:eco_step/Sub/Pages/Scan/testscan.dart';
// import 'package:eco_step/Sub/SignIn&Up/login_page.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'Sub/Components/my_splash.dart';
// import 'Sub/Pages/Map/initialmap_page.dart';
// import 'Sub/Services/auth/login_or_register.dart';
// import 'Sub/Splah&Onboarding/onboarding_screens.dart';
// import 'Sub/Splah&Onboarding/splash_screen.dart';
// import 'Sub/Themes/theme_provider.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:intl/intl.dart';
//
// // Localization Imports
// import 'generated/l10n/app_localziations.dart';
//
// final navigatorKey = GlobalKey<NavigatorState>();
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await FirebaseNotifiApi().initNotifications();
//   final notifications = <Map<String, String>>[];
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => ThemeProvider(),
//       child: MyApp(notifications: notifications),
//     ),
//   );
// }
//
// class MyApp extends StatefulWidget {
//   final List<Map<String, String>> notifications;
//
//   MyApp({Key? key, required this.notifications}) : super(key: key);
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   Locale _locale = Locale('en'); // Default locale
//
//   void setLocale(Locale locale) {
//     setState(() {
//       _locale = locale;
//     });
//   }
//
//   Locale get locale => _locale;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ECO-STEP',
//       debugShowCheckedModeBanner: false,
//       theme: Provider.of<ThemeProvider>(context).themeData,
//       locale: _locale,
//       supportedLocales: [
//         Locale('en', ''), // English
//         Locale('af', ''), // Afrikaans
//         Locale('ar', ''), // Arabic
//         Locale('zh', ''), // Chinese
//         Locale('nl', ''), // Dutch
//         Locale('fr', ''), // French
//         Locale('de', ''), // German
//         Locale('el', ''), // Greek
//         Locale('he', ''), // Hebrew
//         Locale('pl', ''), // Polish
//       ],
//       localizationsDelegates: [
//         AppLocalizations.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       localeResolutionCallback: (locale, supportedLocales) {
//         for (var supportedLocale in supportedLocales) {
//           if (supportedLocale.languageCode == locale?.languageCode &&
//               supportedLocale.countryCode == locale?.countryCode) {
//             return supportedLocale;
//           }
//         }
//         return supportedLocales.first;
//       },
//       home: OnboardingScreen(),
//       navigatorKey: navigatorKey,
//       routes: {
//         '/notifi': (context) => NotificationsPage(notifications: []),
//         '/edu': (context) => EducationScreen(),
//         '/main': (context) => MainScreen(),
//         '/onboard': (context) => OnboardingScreen(),
//         '/login': (context) => LoginOrRegister(),
//       },
//     );
//   }
// }
