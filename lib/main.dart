// @dart=2.9
import 'package:bh_ms/HomeScreens/House_Login_Home.dart';
import 'package:bh_ms/HomeScreens/Master_Home.dart';
import 'package:bh_ms/attendance/attendance_home.dart';
import 'package:bh_ms/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'root_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Boarding System ',
      theme: ThemeData(
          primaryColor: Colors.yellow,
          primaryColorDark: Colors.yellow,
          accentColor: Colors.yellow
      ),
     home: SplashScreen(),
     //home: House_Login_Home(text2: '', text: '',),
    );
  }
}
