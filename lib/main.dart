import 'package:cocktails/UI/screens/cocktails_screen.dart';
import 'package:cocktails/UI/screens/details_screen.dart';
import 'package:cocktails/UI/screens/home_screen.dart';
// import 'package:cocktails/data/network/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Cocktails",
      theme: ThemeData(

      ),
      initialRoute: "/",
      routes: {
        '/': (context) => HomeScreen(),
        '/cocktails': (context) => CocktailsScreen(),
        '/details': (context) => DetailsScreen()
      },
      localizationsDelegates: const [
        AppLocalizations.delegate, 
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('pl')
      ],
    );
  }

  

}

