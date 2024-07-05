import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'add_user_image.dart';


class UserFetchImage extends StatefulWidget {
  const UserFetchImage({super.key});

  @override
  State<UserFetchImage> createState() => _UserFetchImageState();
}

class _UserFetchImageState extends State<UserFetchImage> {

  final TextEditingController nameContoller = TextEditingController();


  File? userImageM; // For Mobile

  Uint8List? userImageW; // For Website



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder(

        stream: FirebaseFirestore.instance.collection("userImage").snapshots(),

        builder: (context, snapshot) {


          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }

          if(snapshot.hasData){

            var dataLength = snapshot.data!.docs.length;

            return ListView.builder(
              itemCount: dataLength,
              itemBuilder: (context, index) {

                String name = snapshot.data!.docs[index]["name"];
                String image = snapshot.data!.docs[index]["image"];
                String productID = snapshot.data!.docs[index]["id"];


                return ListTile(
                  title: Text(name),
                  leading: CircleAvatar(backgroundImage: NetworkImage(image),),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [

                        IconButton(onPressed: (){
                          setState(() {
                            nameContoller.text = name;
                          });
                          showModalBottomSheet(context: context, builder: (context) {

                            void updateUserWithImage()async{
                              await FirebaseStorage.instance.refFromURL(image).delete();
                              UploadTask uploadTask = FirebaseStorage.instance.ref().child("UserData").child(productID).putData(userImageW!);
                              TaskSnapshot taskSnapshot = await uploadTask;
                              String imageUrl = await taskSnapshot.ref.getDownloadURL();
                              await FirebaseFirestore.instance.collection("userImage").doc(productID).update({
                                "name" : nameContoller.text,
                                "image" : imageUrl
                              });
                              Navigator.pop(context);
                            }




                            return StatefulBuilder(builder: (context, setState) {
                              return Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center ,
                                  children: [


                                    GestureDetector(
                                        onTap:()async{
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
                                        child: userImageW != null ? CircleAvatar(
                                          radius: 50,
                                          backgroundImage: userImageW != null ? MemoryImage(userImageW!) : null,
                                        ) :
                                        CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(image),
                                        )
                                    ),

                                    SizedBox(height: 10,),

                                    SizedBox(
                                      width: 200,
                                      child: TextFormField(
                                        controller: nameContoller,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder()
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 10,),


                                    ElevatedButton(onPressed: (){
                                      updateUserWithImage();
                                    }, child: Text("Update Data"))

                                  ],
                                ),
                              );
                            },);
                          },);

                        }, icon: const Icon(Icons.update)),
                        IconButton(onPressed: ()async{

                          await FirebaseFirestore.instance.collection("userImage").doc(productID).delete();
                          FirebaseStorage.instance.refFromURL(image).delete();

                        }, icon: const Icon(Icons.delete)),

                      ],
                    ),
                  ),
                );

              },);
          }

          if(snapshot.hasError){
            return const Center(child: Icon(Icons.error,color: Colors.red,),);
          }

          return Container();


        },),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddUserWithImage(),));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
