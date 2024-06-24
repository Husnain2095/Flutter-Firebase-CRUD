import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mwf07b/forms.dart';

import 'firebaseauth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  bool isHide = true;

  // TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  FirebaseAuthService authService = FirebaseAuthService();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    // name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        margin: EdgeInsets.symmetric(horizontal: 10),

        child: Form(
          key: formKey,
          child: Column(
            children: [


              SizedBox(
                height: 20,
              ),

              // TextFormField(
              //   controller: name,
              //   inputFormatters: [
              //     LengthLimitingTextInputFormatter(30)
              //   ],
              //   maxLength: 30,
              //   validator: (value){
              //     if(value == null || value.isEmpty || value == " "){
              //       return "Name is Required";
              //     }
              //   },
              //   decoration: InputDecoration(
              //     label: Text("Enter Your Name"),
              //     hintText: "John Doe",
              //     border: OutlineInputBorder(),
              //     prefixIcon: Icon(Icons.person),
              //   ),
              // ),

              SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: email,
                validator: (value){
                  if(value == null || value.isEmpty || value == " "){
                    return "Email is Required";
                  }
                },
                decoration: InputDecoration(
                  label: Text("Enter Your Email"),
                  hintText: "john@gmail.com",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: password,
                obscureText: isHide,
                validator: (value){
                  if(value == null || value.isEmpty || value == " "){
                    return "Password is Required";
                  }
                  if(password.text.length < 6){
                    return "Password is Length must be Greater than 6";
                  }
                },
                obscuringCharacter: "*",
                decoration: InputDecoration(
                    label: Text("Enter Your Password"),
                    hintText: "J0hn****1",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.key),
                    suffix: IconButton(onPressed: (){
                      setState(() {
                        isHide = ! isHide;
                      });
                    }, icon: isHide == true ? Icon(Icons.remove_red_eye) : Icon(Icons.panorama_fish_eye))
                ),
              ),

              SizedBox(
                height: 20,
              ),

              ElevatedButton(onPressed: ()async{

                if(formKey.currentState!.validate()){
                  debugPrint(email.text);
                  debugPrint(password.text);

                  authService.loginUser(
                      email: email.text,
                      password: password.text,
                      context: context
                  );
                }

              }, child: Text("Login")),


              SizedBox(
                height: 10,
              ),

              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Forms(),));
                  },
                  child: Text("Don't have an Account Kindly Create"))



            ],
          ),
        ),
      ),
    );
  }
}
