import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_user_data.dart';

class UserFetch extends StatefulWidget {
  const UserFetch({super.key});

  @override
  State<UserFetch> createState() => _UserFetchState();
}

class _UserFetchState extends State<UserFetch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder(

          stream: FirebaseFirestore.instance.collection("userData").snapshots(),

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
                 String address = snapshot.data!.docs[index]["email"];
                 String userID = snapshot.data!.docs[index]["id"];

               return ListTile(
                 title: Text(name),
                 subtitle: Text(address),
                 trailing: IconButton(onPressed: ()async{

                   await FirebaseFirestore.instance.collection("userData").doc(userID).delete();

                 }, icon: Icon(Icons.delete,color: Colors.red,)),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => ExampleWork(),));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
