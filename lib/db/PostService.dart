import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



const String nodeName =  "posts";



class PostService
{

  DatabaseReference ref = FirebaseDatabase.instance.ref();
  

  addPost({Map? post}) async
  {
    //this is going to give a reference to the posts node
    ref.child(nodeName).push().set(post);
  }
  
  
  updatePost({required Map<String, Object?> updatedPost,required String key})
  {
    ref.child('$nodeName/$key').update(updatedPost);
  }

  deletePost({required String key}) async {
    print(key);
    try
    {
      ref.child('$nodeName/$key').remove();
      Get.close(1);
    }
    catch(e)
    {
      print(e);
    }

  }


}