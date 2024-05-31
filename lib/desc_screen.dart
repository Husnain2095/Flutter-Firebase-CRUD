import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mwf07b/api_services.dart';


class DescScreen extends StatefulWidget {
  const DescScreen({super.key,
    required this.movieID
  });


  final int movieID;

  @override
  State<DescScreen> createState() => _DescScreenState();
}

class _DescScreenState extends State<DescScreen> {

  List colors = [Colors.blue, Colors.pink, Colors.red, Colors.green];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: ApiServices.getDataDesc(widget.movieID), builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }

            if(snapshot.hasData){

              Map map = jsonDecode(snapshot.data);

              String movieName = map["tvShow"]["name"];
              String movieStatus = map["tvShow"]["status"];
              String movieDesc = map["tvShow"]["description"];
              String movieImage = map["tvShow"]["image_thumbnail_path"];

              List moviePictures = map["tvShow"]["pictures"];

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                
                        Container(
                          width: double.infinity,
                          height: 260,
                
                        ),
                
                
                        CarouselSlider(
                            items: List.generate(
                                moviePictures.length, (index) => Container(
                              width: double.infinity,
                              height: 200,
                              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(14),
                                image: DecorationImage(image: NetworkImage(moviePictures[index]))
                              ),
                            )),
                            options: CarouselOptions(
                                height: 200,
                                autoPlay: true,
                                viewportFraction: 1.0,
                                enlargeCenterPage: true,
                                aspectRatio: 16 / 9,
                                autoPlayInterval: Duration(milliseconds: 1500)
                            )),
                
                        Positioned(
                          left: 20,
                          top: 100,
                          child: Container(
                            width: 120,
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(14),
                              image: DecorationImage(image: NetworkImage(movieImage))
                            ),
                          ),
                        ),
                
                        Positioned(
                            left: 150,
                            top: 200 ,
                            child: Text(movieName,style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),)),
                
                        Positioned(
                            left: 150,
                            top: 220 ,
                            child: Text(movieStatus,style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),))
                
                      ],
                    ),
                
                    SizedBox(height: 10,),
                
                    Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text("Description",style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),)),
                
                    SizedBox(height: 10,),
                
                    Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(movieDesc,style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),)),
                
                  ],
                ),
              );
            }

            if(snapshot.hasError){
              return Center(child: Icon(Icons.error,color: Colors.red,),);
            }

            return Container();
          },),
    );
  }
}
