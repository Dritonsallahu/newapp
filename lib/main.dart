import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:news_app/features/presentation/providers/post_provider.dart';
import 'package:news_app/features/presentation/providers/request_network_provider.dart';
import 'package:news_app/features/presentation/providers/user_provider.dart';
import 'package:news_app/l10n/l10n.dart';
import 'package:news_app/core/themes/dark_mode_theme.dart';
import 'package:news_app/core/themes/light_mode_theme.dart';
import 'package:news_app/features/presentation/screens/navigator_page.dart';
import 'package:news_app/features/presentation/widgets/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid){
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => di.sl<PostProvider>()),
          ChangeNotifierProvider(create: (_) => di.sl<UserProvider>()),
          ChangeNotifierProvider(create: (_) => di.sl<RequestNetworkProvider>()),
        ],
        child: MaterialApp(
          title: 'MMC NEWS',
          darkTheme: darkThemeData(context),
          theme: lightThemeData(context),
          supportedLocales: L10n.all,debugShowCheckedModeBanner: false,
          locale: const Locale('en'),
          localizationsDelegates:   const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const SplashScreen(),
        ),
      );
    }
    else{
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => di.sl<PostProvider>()),
          ChangeNotifierProvider(create: (_) => di.sl<UserProvider>()),
          ChangeNotifierProvider(create: (_) => di.sl<RequestNetworkProvider>()),
        ],
        child: CupertinoApp(
          // theme: lightThemeData(context),
          supportedLocales: L10n.all,debugShowCheckedModeBanner: false,
          locale: const Locale('en'),
          localizationsDelegates:   const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const SplashScreen(),
        ),
      );
    }

  }
}
