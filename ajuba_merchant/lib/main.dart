import 'package:ajuba_merchant/home_page.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import './utils/routes.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(primarySwatch: Colors.indigo,
          //fontFamily: GoogleFonts.lato().fontFamily

      ),


      initialRoute: Routes.login,
      routes: {
        '/': (context)=> LoginPage(),
        Routes.login: (context) => LoginPage()

      },
    );
  }
}
