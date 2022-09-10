import 'package:blogapp/db/PostService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'homePage.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final GlobalKey<FormState> formkey = new GlobalKey();

  String? title;
  String? body;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
      ),
      body: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Post title",
                      border: OutlineInputBorder()
                  ),
                  validator: (val){
                    if(val!.isEmpty ){
                      return "title field cant be empty";
                    }else if(val.length > 16){
                      return "title cannot have more than 16 characters ";
                    }
                  },
                  onSaved: (val) => title = val,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Post body",
                      border: OutlineInputBorder()
                  ),
                  validator: (val){
                    if(val!.isEmpty){
                      return "body field cant be empty";
                    }
                  },
                  onSaved: (val) => body = val,
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(onPressed: (){
        insertPost();
      },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.red,
        tooltip: "add a post",),
    );
  }


  void insertPost() {
    final FormState? form = formkey.currentState;
    if(form!.validate()){
      form.save();
      PostService postService = PostService();
      postService.addPost(post: {"BODY":body,"TITLE":title,"DATE": DateTime.now().microsecondsSinceEpoch});
      form.reset();
      Get.close(1);
      // postService.addPost();
    }
  }
}



class EditUserDetails extends StatefulWidget {
  final String title;
  final String body;
  final String keyy;


  const EditUserDetails({Key? key, required this.title, required this.body, required this.keyy}) : super(key: key);

  @override
  State<EditUserDetails> createState() => _EditUserDetailsState();
}

class _EditUserDetailsState extends State<EditUserDetails> {

  final GlobalKey<FormState> formkey = new GlobalKey();

  late String title;
  late String body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit post"),
        elevation: 0.0,
      ),
      body: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.title,
                  decoration: InputDecoration(
                      labelText: "Post tilte",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => title = val!,
                  validator: (val){
                    if(val!.isEmpty){
                      return "title field cant be empty";
                    }else if(val.length > 16){
                      return "title cannot have more than 16 characters ";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.body,
                  decoration: InputDecoration(
                      labelText: "Post body",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => body = val!,
                  validator: (val){
                    if(val!.isEmpty){
                      return "body field cant be empty";
                    }
                  },
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(onPressed: (){
        insertPost();
//        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      },
        child: Icon(Icons.edit, color: Colors.white,),
        backgroundColor: Colors.red,
        tooltip: "exit a post",),
    );
  }

  void insertPost() {
    final FormState? form = formkey.currentState;
    if(form!.validate()){
      form.save();
      form.reset();
      // widget.post.date = DateTime.now().millisecondsSinceEpoch;
      // PostService postService = PostService(widget.post.toMap());
      // postService.updatePost();
    }
  }


}