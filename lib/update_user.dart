import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key,
  required this.uName,
  required this.uEmail,
  required this.uPassword,
  required this.uAddress,
    required this.uID
  });

  final String uEmail;
  final String uID;
  final String uName;
  final String uPassword;
  final String uAddress;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {

  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController address=TextEditingController();
  bool isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    name.text = widget.uName;
    email.text = widget.uEmail;
    password.text = widget.uPassword;
    address.text = widget.uAddress;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: name,
            decoration: InputDecoration(
                label: Text("Enter your name"),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person)
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: email,
            decoration: InputDecoration(
                label: Text("Enter your email"),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email)
            ),

          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: password,
            decoration: InputDecoration(
                label: Text("Enter password"),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.remove_red_eye)
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: address,
            decoration: InputDecoration(
                label: Text("Enter your address"),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_city)

            ),
          ),

          ElevatedButton(onPressed: ()async{
            // await FirebaseFirestore.instance.collection("userData").add({
            //   "name" : name.text,
            //   "email" : email.text,
            //   "password" : password.text,
            //   "address" : address.text
            // });

            setState(() {
              isLoading = !isLoading;
            });
            await FirebaseFirestore.instance.collection("userData").doc(widget.uID).update(
                {
                  "name" : name.text,
                  "email" : email.text,
                  "password" : password.text,
                  "address" : address.text
                });
            name.clear();
            email.clear();
            password.clear();
            address.clear();
            setState(() {
              isLoading = !isLoading;
            });
            Navigator.pop(context);
          }, child: isLoading ? CircularProgressIndicator() : Text("Update Data"))

        ],
      ),


    );
  }
}