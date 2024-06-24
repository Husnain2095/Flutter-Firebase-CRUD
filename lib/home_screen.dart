import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mwf07b/firebaseauth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseAuthService authService = FirebaseAuthService();


  String uEmail = "";

  Future getUserCred()async{
    SharedPreferences userCred = await SharedPreferences.getInstance();
    var cred = userCred.getString("email");
    return cred;
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserCred().then((value) {
      setState(() {
        uEmail = value;
      });
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          authService.userLogout(context);
        },
        child: Center(
          child: Text(uEmail),
        ),
      ),
    );
  }
}
