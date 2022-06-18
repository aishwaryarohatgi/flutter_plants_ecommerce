import 'package:flutter/material.dart';
// import 'package:flutter_plants_ecommerce/pages/home_page.dart';
import 'package:flutter_plants_ecommerce/pages/onboarding_screen.dart';
// import 'package:flutter_plants_ecommerce/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Plants Ecommerce',
      // theme: ThemeData(
      //   // primarySwatch: Colors.green,
      //   // Define the default brightness and colors.
      //   brightness: Brightness.light,
      //   primaryColor: Colors.lightGreen[800],

      //   // Define the default font family.
      //   fontFamily: 'Roboto',

      //   // Define the default `TextTheme`. Use this to specify the default
      //   // text styling for headlines, titles, bodies of text, and more.
      //   textTheme: const TextTheme(
      //     headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      //     headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      //     bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      //   ),
      // ),
      home: OnboardingScreen(),
    );
  }
}
