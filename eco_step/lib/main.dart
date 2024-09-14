import 'package:eco_step/Sub/Notifications/FirebaseNotifiApi.dart';
import 'package:eco_step/Sub/Notifications/notification_page.dart';
import 'package:eco_step/Sub/Pages/Education/initaialedu_page.dart';
import 'package:eco_step/Sub/Pages/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Sub/Services/auth/login_or_register.dart';
import 'Sub/Splah&Onboarding/onboarding_screens.dart';
import 'Sub/Themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart'; // Add this line

import 'generated/l10n/app_localziations.dart';

// Localization Imports
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
        // Other supported locales...
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
      home: ResponsiveWrapper.builder(
        OnboardingScreen(), // Ensure this is your default screen
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
        background: Container(color: Color(0xFFF5F5F5)),
      ),
      navigatorKey: navigatorKey,
      routes: {
        '/': (context) => OnboardingScreen(), // This is the root route
        '/notifi': (context) => NotificationsPage(notifications: []),
        '/edu': (context) => EducationScreen(),
        '/main': (context) => MainScreen(),
        '/onboard': (context) => OnboardingScreen(),
        '/login': (context) => LoginOrRegister(),
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (context) => OnboardingScreen(), // Fallback screen if route is unknown
        );
      },
    );
  }
}


class ResponsiveBreakpoint {
  static autoScale(int i, {required String name}) {}

  static resize(int i, {required String name}) {}
}

class ResponsiveWrapper {
  static builder(OnboardingScreen onboardingScreen, {required int maxWidth, required int minWidth, required bool defaultScale, required List breakpoints, required Container background}) {}
}

