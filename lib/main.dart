import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mwf07b/api_services.dart';
import 'package:mwf07b/desc_screen.dart';
import 'package:mwf07b/firebase_options.dart';
import 'package:mwf07b/forms.dart';
import 'package:mwf07b/login_screen.dart';
import 'package:mwf07b/splash_screen.dart';
import 'package:mwf07b/user_fetch.dart';

import 'add_user_data.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UserFetch(),
    );
  }
}


class FetchScreen extends StatefulWidget {
  const FetchScreen({super.key});

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: ApiServices.getApiData(),
          builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }

            if(snapshot.hasData){

              Map map = jsonDecode(snapshot.data);
              List myData = map["tv_shows"];

              return ListView.builder(
                itemCount: myData.length,
                itemBuilder: (context, index) {

                  int movieID = myData[index]["id"];
                String movieName = myData[index]["name"];
                String movieImage = myData[index]["image_thumbnail_path"];
                String movieNetwork = myData[index]["network"];

                return GestureDetector(

                  onTap: (){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$movieID")));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DescScreen(movieID: movieID,),));

                  },

                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(movieImage),
                    ),
                    title: Text(movieName),
                    subtitle: Text(movieNetwork),
                  ),
                );
              },);
            }

            if(snapshot.hasError){
              return const Center(child: Icon(Icons.error,color: Colors.red,),);
            }


            return Container();


          },),
    );
  }
}


