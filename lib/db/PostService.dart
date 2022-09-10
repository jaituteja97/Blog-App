import 'package:firebase_database/firebase_database.dart';



const String nodeName =  "posts";



class PostService
{

  DatabaseReference ref = FirebaseDatabase.instance.ref();
  

  addPost({Map? post}) async
  {
    //this is going to give a reference to the posts node
    ref.child(nodeName).push().set(post);
  }
  
  
  updatePost(Map updatedPost)
  {
    // ref.child(nodeName).update();
  }

  deletePost(){
    // ref.child('$nodeName/${post['key']}').remove();
  }






}