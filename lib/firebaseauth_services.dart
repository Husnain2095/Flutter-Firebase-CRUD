
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mwf07b/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class FirebaseAuthService{


  void registerUser ({String? email , String? password, BuildContext? context})async{
   try{
     await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: email!,
         password: password!
     );
     ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: Text("Register Successful")));
   } on FirebaseAuthException catch(ex){
     ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: Text(ex.code.toString())));
   }
  }


  void loginUser ({String? email , String? password, BuildContext? context})async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email!,
          password: password!
      );
      SharedPreferences userCred = await SharedPreferences.getInstance();
      var cred = userCred.setString("email", email);
      debugPrint("$cred");
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: Text("Login Successful")));
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
    } catch(ex){
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: Text(ex.toString())));
    }
  }

  void userLogout(BuildContext context)async{
    await FirebaseAuth.instance.signOut();
    
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
  }

}