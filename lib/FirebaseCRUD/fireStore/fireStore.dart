import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/FirebaseCRUD/PostEndGetData/postScreen.dart';
import 'package:flutter_application_1/FirebaseCRUD/fireBaseServices/Firebaseervices.dart';
import 'package:flutter_application_1/FirebaseCRUD/fireStore/AddfireStore.dart';

class fireStore extends StatefulWidget {
  const fireStore({super.key});

  @override
  State<fireStore> createState() => _fireStoreState();
}

class _fireStoreState extends State<fireStore> {
    //final searchcontr = TextEditingController();
  
  //for updated value
  final editcontr = TextEditingController();
  
  final fireStore = FirebaseFirestore.instance.collection('user').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
           SizedBox(height: 50,),

            StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator();
                }
                if(snapshot.hasError){
                  return Text("Some Error");
                }
                return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final title = snapshot.data!.docs[index]['title'].toString();
                return ListTile(
                  
                  title: Text(snapshot.data!.docs[index]['title'].toString()),
                  subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                  trailing: PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: ListTile(
                          onTap: (){
                            Navigator.pop(context);
                            showMydialog(title,snapshot.data!.docs[index]['id'].toString());
                          },
                          leading: Icon(Icons.edit),
                          title:Text("edit"),
                        )),
                        PopupMenuItem(
                        value: 1,
                        onTap: (){
                          //ref.child(snapshot.child('id').value.toString()).remove();
                        },
                        child: ListTile(
                          leading: Icon(Icons.delete),
                          onTap: (){
                            ref.doc(snapshot.data!.docs[index]['id'].toString()).delete().then((value){
                              FirebaseServices().ToastMessge("Data deleted");
                            }).onError((error, stackTrace){
                              FirebaseServices().ToastMessge(error);
                            });
                          },
                          title:Text("delete"),
                        ))
                    ],
                  ),
                );
              },),
            );
            },),
            
          ]),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddFireStore(),));
        },
        child: Icon(Icons.add,size: 25,color: Colors.white,),
        ),
    );
  }

   Future<void> showMydialog(String title,id)async{
    editcontr.text = title;
      return showDialog(
        context: context, 
        builder: (context) {
          return AlertDialog(
            title: Text("updated"),
            content: Container(child: TextFormField(
              controller: editcontr,
              decoration: InputDecoration(hintText:"enter here" ),
            ),),
            actions: [
              TextButton(
                onPressed: (){
                  ref.doc(id).update({
                    "title" : editcontr.text.toLowerCase(),
                  }).then((value){
                    FirebaseServices().ToastMessge("Data Updated");
                  }).onError((error, stackTrace){
                    FirebaseServices().ToastMessge(error);
                  });
                  Navigator.pop(context);
                }, 
                child: Text("update")),
                TextButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                child: Text("cancel")),
            ],
          );
        },);
    }}