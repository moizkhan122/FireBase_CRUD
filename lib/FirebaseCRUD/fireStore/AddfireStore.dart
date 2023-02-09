import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/FirebaseCRUD/fireBaseServices/Firebaseervices.dart';
import 'package:flutter_application_1/FirebaseCRUD/fireStore/fireStore.dart';

class AddFireStore extends StatefulWidget {
      AddFireStore({super.key});

  @override
  State<AddFireStore> createState() => _AddFireStoreState();
}

class _AddFireStoreState extends State<AddFireStore> {
  final DataFireStoreControlller = TextEditingController();

  bool loading = false;
  final fireStore = FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add To FireStore Data"),
      ),
      body: Column(
        children: [
          SizedBox(height: 70,),

          TextFormField(maxLines: 4,
            controller: DataFireStoreControlller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Here"),
          ),
          SizedBox(height: 30,),
          
          ElevatedButton(
            onPressed: (){
              final id = DateTime.now().millisecondsSinceEpoch.toString();
              fireStore.doc(id).set({
                'title' : DataFireStoreControlller.text.toString(),
                'id' : id
              }).then((value){
                FirebaseServices().ToastMessge("data added");
              }).onError((error, stackTrace){
                FirebaseServices().ToastMessge(error);
              });
          },
           child: Text("Add",style: TextStyle(color: Colors.black,fontSize: 20),))
        ]),
    );
  }
}