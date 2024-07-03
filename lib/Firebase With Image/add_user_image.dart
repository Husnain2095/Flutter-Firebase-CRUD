import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';


class AddUserWithImage extends StatefulWidget {
  const AddUserWithImage({super.key});

  @override
  State<AddUserWithImage> createState() => _AddUserWithImageState();
}

class _AddUserWithImageState extends State<AddUserWithImage> {

  File? userImageM; // For Mobile

  Uint8List? userImageW; // For Website
  
  TextEditingController userName = TextEditingController();

  void addUserWithImage()async{

    String userID = Uuid().v1();

    UploadTask uploadTask = FirebaseStorage.instance.ref().child("UserData").child(userID).putData(userImageW!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    addUser(userID: userID,userImage: imageUrl);
    Navigator.pop(context);
  }


  void addUser({String? userID, String? userImage})async{
    await FirebaseFirestore.instance.collection("userImage").doc(userID).set({
      "id" : userID,
      "name" : userName.text,
      "image" : userImage
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            GestureDetector(
              onTap: ()async{
                XFile? pickImage = await ImagePicker().pickImage(source: ImageSource.gallery);

                if(pickImage != null){
                  if(kIsWeb){
                    var convertedFile = await pickImage.readAsBytes();
                    setState(() {
                      userImageW = convertedFile;
                    });
                  }
                  else{
                    File convertedFile = File(pickImage.path);
                    setState(() {
                      userImageM = convertedFile;
                    });
                  }
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Image Not Selected")));
                }

                },
              child: kIsWeb ? CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue,
                backgroundImage: userImageW != null ? MemoryImage(userImageW!) : null,
              ) : CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue,
                backgroundImage: userImageM != null ? FileImage(userImageM!) : null,
              ),
            ),

            SizedBox(
              height: 10,
            ),
            
            SizedBox(
              width: 200,
              child: TextFormField(
                controller: userName,
                decoration: InputDecoration(
                  border: OutlineInputBorder()
                ),
              ),
            ),
            
            SizedBox(
              height: 10,
            ),
            
            ElevatedButton(onPressed: (){
              addUserWithImage();
            }, child: Text("Add Data"))
            
          ],

        ),
      ),
    );
  }
}
