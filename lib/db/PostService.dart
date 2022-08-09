import 'package:blogapp/model/post.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PostService
{
  String nodeName =  "posts";
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  

  addPost({Map? post}) async
  {
    //this is going to give a reference to the posts node
    ref.child(nodeName).push().set(post);
  }


}