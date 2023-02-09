import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/FirebaseCRUD/PostEndGetData/postScreen.dart';


class post extends StatefulWidget {
  const post({super.key});

  @override
  State<post> createState() => _postState();
}

class _postState extends State<post> {

  final searchcontr = TextEditingController();
  final auth = FirebaseAuth.instance;
  //instance/object of table in firebase
  final ref = FirebaseDatabase.instance.ref('post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
         SizedBox(height: 50,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 15),
           child: TextFormField(
            controller: searchcontr,
            decoration: InputDecoration(
              //serach by filter
              border: OutlineInputBorder(),
              hintText: "Enter text"),
           ),
         ),

         //first wat or fetching the data from firebase
         Expanded(
           child: StreamBuilder(
            stream: ref.onValue,
            builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {
              
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              }
              else{
         
                Map<dynamic,dynamic> map = snapshot.data!.snapshot.value as dynamic;
                List<dynamic> list = [];
                list.clear();
                list = map.values.toList();
                return ListView.builder(
                  itemCount: snapshot.data!.snapshot.children.length,
                  itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(list[index]['title']),
                    subtitle: Text(list[index]['id']),
                  );
                },);
              }
              
           },),
         ),
         //second wat or fetching the data from firebase
          //work like listview builder which is built in firebase
         SizedBox(height: 30,),
          // Expanded(
          //   child: FirebaseAnimatedList(
          //     query: ref,
          //     //if there is no data it will return
          //     defaultChild: Text("Loading"),
          //    itemBuilder: (context, snapshot, animation, index) {
          //      return ListTile(
          //       title: Text(snapshot.child('title').value.toString()),);
          //    },),
          // )
        ]),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen(),));
        },
        child: Icon(Icons.add,size: 25,color: Colors.white,),
        ),
    );
  }
}