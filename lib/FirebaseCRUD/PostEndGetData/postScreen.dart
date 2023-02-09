import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/FirebaseCRUD/fireBaseServices/Firebaseervices.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  
  final DatabaseControlller = TextEditingController();
  bool loading = false;
    //create a table name post in firebase
  final firebaseDatabase = FirebaseDatabase.instance.ref('post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 70,),

          TextFormField(maxLines: 4,
            controller: DatabaseControlller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Here"),
          ),
          SizedBox(height: 30,),
          
          ElevatedButton(
            onPressed: (){
              final id = DateTime.now().millisecondsSinceEpoch.toString(); 
            firebaseDatabase.child(id).set({
              'id' : id,
              'title' : DatabaseControlller.text.toString(),
            }).then((value){
              FirebaseServices().ToastMessge("post added");
            }).onError((error, stackTrace){
              FirebaseServices().ToastMessge(error.toString());
            });
          },
           child: Text("Add",style: TextStyle(color: Colors.black,fontSize: 20),))
        ]),
    );
  }
}