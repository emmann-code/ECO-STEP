import 'package:eco_step/Sub/Pages/Profile/profile.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'ECO-STEP',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData,
      home: SplashScreen(),
      // home: ProfilePage( email: '',),
      initialRoute: '/onboard',
      routes: {
        '/onboard': (context) => OnboardingScreen(),
        '/login': (context) =>  LoginOrRegister(),
      },
      // home: InitialMapPage(),
      // home: MyWidget(),
    );
  }
}


// import 'package:eco_step/Sub/Pages/Profile/profile.dart';
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
//
// // Localization Imports
// import 'ln10/app_localziations.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => ThemeProvider(),
//       child: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
//
//   static _MyAppState? of(BuildContext context) =>
//       context.findAncestorStateOfType<_MyAppState>();
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
//   Locale get locale => _locale; // Add this getter
//
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//
//     return MaterialApp(
//       title: 'ECO-STEP',
//       debugShowCheckedModeBanner: false,
//       theme: themeProvider.themeData,
//       locale: _locale,
//       supportedLocales: [
//         Locale('en', ''), // English
//         Locale('af', ''), // Africans
//         Locale('ar', ''), // Arabic
//         Locale('zh', ''), // Chinese
//         Locale('nl', ''), // Dutch
//         Locale('fr', ''), // French
//         Locale('de', ''), // German
//         Locale('el', ''), // Greek
//         Locale('he', ''), // Hebrew
//         Locale('pl', ''), // Polish
//         // Add other locales here
//       ],
//       localizationsDelegates: [
//         AppLocalizations.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       home: SplashScreen(),
//       initialRoute: '/onboard',
//       routes: {
//         '/onboard': (context) => OnboardingScreen(),
//         '/login': (context) => LoginOrRegister(),
//         // Add other routes as needed
//       },
//     );
//   }
// }
//




