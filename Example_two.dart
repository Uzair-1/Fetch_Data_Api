import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Example_two extends StatefulWidget {
  const Example_two({Key? key}) : super(key: key);

  @override
  State<Example_two> createState() => _Example_twoState();
}

class _Example_twoState extends State<Example_two> {

  List<Photo> photosList=[];
  Future<List<Photo>> getPhoto() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data){
        Photo photo = Photo(title: i ["title"], url: i ["url"],id: i["id"]);
        photosList.add(photo);
      }return photosList;
    }
    else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api App "),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Expanded(
             child:  FutureBuilder(
                 future: getPhoto(),
                 builder: (context ,AsyncSnapshot<List<Photo>> snapshot){
                   return ListView.builder(
                       itemCount: photosList.length,
                       itemBuilder: (BuildContext context ,index){
                         return ListTile(
                           leading: CircleAvatar(
                             backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                           ),
                           subtitle: Text(snapshot.data![index].title.toString()),
                           title: Text("Title Id :" +snapshot.data![index].id.toString()),
                         );
                       }
                   );
                 }
             )
         )
        ],
      ),
    );
  }
}

// if pluging not  creating the Api Models for us then the next steps how we create own file .

class Photo{
  String  title , url;
  int id;
  Photo({required this.title,required this.url , required this.id});
}