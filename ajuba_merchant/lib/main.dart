// ignore: import_of_legacy_library_into_null_safe
import 'package:ajuba_merchant/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import './utils/routes.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        Routes.login: (context) => LoginPage(),
        Routes.home:(context) => HomePage()

      },
    );
  }
}
