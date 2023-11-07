import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sales_app_flutter/model/data.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
   HomePage({super.key});

  List<Team> teams =[];

  // get teams
  Future getData()async{
    var response = await http.get(Uri.https('fakestoreapi.com','products'));
    var jsonData = jsonDecode(response.body);
    for(var eachTeam in jsonData){
      final team = Team(description: eachTeam['description'], title: eachTeam['title']);
      teams.add(team);
    }
    print(teams.length);
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: FutureBuilder(future: getData(), builder: (context,snapshot){
        if (snapshot.connectionState==ConnectionState.done) {
          return ListView.builder(
            itemCount:teams.length ,
            itemBuilder: (context,index){
            return Container(
              decoration: BoxDecoration(color: Colors.grey[200],
              ),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(teams[index].title,),
                      Text(teams[index].description,),
                    ],
                  ),
                ),
              ),
            );
          });
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      }),
    );
  }
}