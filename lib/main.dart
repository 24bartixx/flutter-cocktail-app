import 'package:cocktails/UI/screens/cocktails_screen.dart';
import 'package:cocktails/UI/screens/details_screen.dart';
import 'package:cocktails/UI/screens/home_screen.dart';
// import 'package:cocktails/data/network/api_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Coctails App",
      theme: ThemeData(

      ),
      initialRoute: "/",
      routes: {
        '/': (context) => HomeScreen(),
        '/cocktails': (context) => CocktailsScreen(),
        '/details': (context) => DetailsScreen()
      }
    );
  }

  

}

