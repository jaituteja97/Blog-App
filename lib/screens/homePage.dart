import 'package:blogapp/db/PostService.dart';
import 'package:blogapp/screens/addPost.dart';
import 'package:blogapp/screens/editPost.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  PostService postService = PostService();

  late Map data;
  bool isLoading = true;
  List postList = [];
  Query query  = FirebaseDatabase.instance.ref().child("posts");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text("Flutter Blog"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: FirebaseAnimatedList(query: query, itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
        Map student = snapshot.value as Map;
        return blogCard(title: student["TITLE"],body: student["BODY"],date: student["DATE"],key: snapshot.key);

      },),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPost()));
        },
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        tooltip: "add a post",
      ),
    );
  }
}

Widget blogCard({required String title,required String body,int? date,String? key})
{
  return  InkWell(
    onTap: ()
    {
       Get.to(() => EditUserDetails(title: title, body: body,keyy: key!));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(color: Colors.white,
        child: ListTile(
          title: Text(title,style: const TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
          trailing: Text(timeago.format(getdate(date!)),style: TextStyle(fontSize: 14.0,color: Colors.grey)),
          subtitle: Text(body),
        ),
      ),
    ),
  );

}


DateTime getdate(int epoc) {
  var date = new DateTime.fromMicrosecondsSinceEpoch(epoc);
  return date;
}

