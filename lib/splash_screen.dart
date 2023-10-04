import 'dart:async';

import 'package:flutter/material.dart';

import 'Authentication/authentication_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {

  double _progress = 0;

  void startTimer() {
    new Timer.periodic(
      Duration(seconds: 1),
          (Timer timer) =>
         setState ((){if (_progress == 1) {
        timer.cancel();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AuthenticationPage()), (route) => false);
      } else {
        _progress += 0.2;
      }
      },
    ));
  }

  @override
  void initState(){
    super.initState();
    setState(() {
      _progress = 0;
    });
    startTimer();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 186, 187, 247),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/splash1.png"),
                /*color: Colors.blueAccent,
                size: 100.0,*/
              ),
              SizedBox(height: 10.0),
              Padding(padding: EdgeInsets.only(left: 10.0,right: 10.0),
              child: Center(child: Text('OSEI TUTU SENIOR HIGH\nBOARDING HOUSE MANAGEMENT SYSTEM', style: TextStyle(color: Color.fromARGB(255, 14, 4, 53), fontSize: 18.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
              ),
              
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 40.0),
              child: CircularProgressIndicator(
                value: _progress,
                strokeWidth: 5,
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 14, 3, 53)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
