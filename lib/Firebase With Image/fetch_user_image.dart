import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mwf07b/update_user.dart';

import 'add_user_image.dart';


class UserFetchImage extends StatefulWidget {
  const UserFetchImage({super.key});

  @override
  State<UserFetchImage> createState() => _UserFetchImageState();
}

class _UserFetchImageState extends State<UserFetchImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder(

        stream: FirebaseFirestore.instance.collection("userImage").snapshots(),

        builder: (context, snapshot) {


          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }

          if(snapshot.hasData){

            var dataLength = snapshot.data!.docs.length;

            return ListView.builder(
              itemCount: dataLength,
              itemBuilder: (context, index) {

                String name = snapshot.data!.docs[index]["name"];
                String image = snapshot.data!.docs[index]["image"];


                return ListTile(
                  title: Text(name),
                  leading: CircleAvatar(backgroundImage: NetworkImage(image),),
                );

              },);
          }

          if(snapshot.hasError){
            return Center(child: Icon(Icons.error,color: Colors.red,),);
          }

          return Container();


        },),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddUserWithImage(),));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
