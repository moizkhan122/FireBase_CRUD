//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/FirebaseCRUD/PostEndGetData/postScreen.dart';
import 'package:flutter_application_1/FirebaseCRUD/fireBaseServices/Firebaseervices.dart';

class FetchDataWithFilter extends StatefulWidget {
  const FetchDataWithFilter({super.key});

  @override
  State<FetchDataWithFilter> createState() => _FetchDataWithFilterState();
}

class _FetchDataWithFilterState extends State<FetchDataWithFilter> {
  final searchcontr = TextEditingController();
  
  //for updated value
  final editcontr = TextEditingController();
  //final auth = FirebaseAuth.instance;
  //instance/object of table in firebase
  final ref = FirebaseDatabase.instance.ref('post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
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
                onChanged: (String value){
                  setState(() {
                    
                  });
                },
             ),
           ),
        
           //first wat or fetching the data from firebase
          //  Expanded(
          //    child: StreamBuilder(
          //     stream: ref.onValue,
          //     builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {
                  
          //       if(!snapshot.hasData){
          //         return CircularProgressIndicator();
          //       }
          //       else{
           
          //         Map<dynamic,dynamic> map = snapshot.data!.snapshot.value as dynamic;
          //         List<dynamic> list = [];
          //         list.clear();
          //         list = map.values.toList();
          //         return ListView.builder(
          //           itemCount: snapshot.data!.snapshot.children.length,
          //           itemBuilder: (context, index) {
          //           return ListTile(
          //             title: Text(list[index]['title']),
          //             subtitle: Text(list[index]['id']),
          //           );
          //         },);
          //       }
                
          //    },),
          //  ),
           //second wat or fetching the data from firebase
            //work like listview builder which is built in firebase
           SizedBox(height: 30,),
        
            Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                //if there is no data it will return
                defaultChild: Text("Loading"),
               itemBuilder: (context, snapshot, animation, index) {
        
                final title  = snapshot.child('title').value.toString();
        
                  if(searchcontr.text.isEmpty){
                    return ListTile(
                  title: Text(snapshot.child('title').value.toString()),
                  subtitle: Text(snapshot.child('id').value.toString()),
                  //updated items
                  trailing: PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: ListTile(
                          onTap: (){
                            Navigator.pop(context);
                            showMydialog(title,snapshot.child('id').value.toString());
                          },
                          leading: Icon(Icons.edit),
                          title:Text("edit"),
                        )),
                        PopupMenuItem(
                        value: 1,
                        onTap: (){
                          ref.child(snapshot.child('id').value.toString()).remove();
                        },
                        child: ListTile(
                          leading: Icon(Icons.delete),
                          title:Text("delete"),
                        ))
                    ],
                  ),
                  );
                  }else if(title.toLowerCase().contains(searchcontr.text.toLowerCase().toString())){
                    return ListTile(
                  title: Text(snapshot.child('title').value.toString()),
                  subtitle: Text(snapshot.child('id').value.toString()),
                  );
                  }else{
                      return Container();
                  }
                 
               },),
            )
          ]),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen(),));
        },
        child: Icon(Icons.add,size: 25,color: Colors.white,),
        ),
    );
    
  }
   Future<void> showMydialog(String title,id)async{
    searchcontr.text = title;
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
                  ref.child(id).update({
                    'title' : editcontr.text.toUpperCase(),
                  }).then((value){
                    FirebaseServices().ToastMessge("post updated");
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
    }
}