
import 'package:ajuba_merchant/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/login.dart';
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
      theme: ThemeData(primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[900],

        )
        //fontFamily: GoogleFonts.lato().fontFamily

      ),


      initialRoute: Routes.home,
      routes: {
        '/': (context)=> HomePage(),
        //Routes.login: (context) => LoginPage(),
        //Routes.home:(context) => HomePage()

      },
    );
  }
}
