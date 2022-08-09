import 'package:blogapp/db/PostService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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