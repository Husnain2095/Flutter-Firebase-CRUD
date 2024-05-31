import 'package:flutter/material.dart';

class Forms extends StatefulWidget {
  const Forms({super.key});

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {


  bool isHide = true;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        margin: EdgeInsets.symmetric(horizontal: 10),

        child: Column(
          children: [


            SizedBox(
              height: 20,
            ),

            TextFormField(
              controller: name,
              decoration: InputDecoration(
                label: Text("Enter Your Name"),
                hintText: "John Doe",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            TextFormField(
              controller: email,
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

            ElevatedButton(onPressed: (){

              debugPrint(name.text);
              debugPrint(email.text);
              debugPrint(password.text);

              name.clear();
              email.clear();
              password.clear();

            }, child: Text("Click Me"))



          ],
        ),
      ),
    );
  }
}
