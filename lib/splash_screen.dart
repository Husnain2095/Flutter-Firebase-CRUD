import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mwf07b/home_screen.dart';
import 'package:mwf07b/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  void getUserCred()async{
    SharedPreferences userCred = await SharedPreferences.getInstance();
    var cred = userCred.getString("email");

    if(cred != null){
      Timer(Duration(milliseconds: 2500), () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),)),);
    }
    else {
      Timer(Duration(milliseconds: 2500), () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),)),);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    getUserCred();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Splash Screen"),
      ),
    );
  }
}
