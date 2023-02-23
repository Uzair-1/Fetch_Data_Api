import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/PostModels.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {

  List<PostModels> postList = [];
Future<List<PostModels>> getPostApi() async{
  final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
  var data= jsonDecode(response.body.toString());
  if(response.statusCode==200){
    for(Map i in data){
      postList.add(PostModels.fromJson(i));
    } return postList;
  }
  else{
    return postList;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(" Fetch Api "),
          backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
         Expanded(
             child:  FutureBuilder(
               future:getPostApi(),
               builder: (context,snapshot){
                 if(!snapshot.hasData){
                   return Text("Loading...");
                 }
                 else
                 {
                   return ListView.builder(
                       itemCount: postList.length,
                       itemBuilder: (BuildContext context,index) {
                         return Card(
                           child: Padding(
                             padding: EdgeInsets.all(10.0),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("Tilte ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                 Text(postList[index].title.toString()),
                                 SizedBox(height: 5,),
                                 Text("Description ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                 SizedBox(height: 5,),
                                 Text(postList[index].body.toString()),
                               ],
                             ),
                           ),
                         );
                       }
                   );
                 }
               },
             )
         )
        ],
      ),

      );

  }


}

