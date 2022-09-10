import 'package:blogapp/db/PostService.dart';
import 'package:blogapp/screens/homePage.dart';
import 'package:flutter/material.dart';




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

  PostService postService = PostService();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(onPressed: (){
            postService.deletePost(key: widget.keyy);
          }, icon: const Icon(Icons.delete))
        ],
        title: const Text("Edit post"),
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
      postService.updatePost(updatedPost: {"BODY":body,"TITLE":title,"DATE": DateTime.now().microsecondsSinceEpoch},key: widget.keyy);
    }
  }


}