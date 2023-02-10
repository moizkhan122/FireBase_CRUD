import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/FirebaseCRUD/fireBaseServices/Firebaseervices.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Image_Picked extends StatefulWidget {
   Image_Picked({super.key});

  @override
  State<Image_Picked> createState() => _Image_PickedState();
}

class _Image_PickedState extends State<Image_Picked> {
  File? image;

  DatabaseReference dataBaseRef = FirebaseDatabase.instance.ref('post');

  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future getImage()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    setState(() {
      if(pickedFile!=null){
        image = File(pickedFile.path);
      }else{
        print("No Image Found");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Image Picker from Gallery")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: (){
                  getImage();
                },
                child: Container(
                  width: 120,
                  height: 100,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                  child: image != null ? Image.file(image!.absolute) :Icon(Icons.image,size: 30,color: Colors.black,),
                  ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: ()async{
                firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/folderName'+'1234');
                firebase_storage.UploadTask uploadTask = ref.putFile(image!.absolute);

                 Future.value(uploadTask).then((value){
                  var newUrl = ref.getDownloadURL();
                
                dataBaseRef.child('1').set({
                  'id' : '1234',
                  'title' : newUrl.toString(),
                });
                FirebaseServices().ToastMessge("Data Oploaded");
                 }).onError((error, stackTrace){
                  FirebaseServices().ToastMessge(error);
                 });
              },  
              child: Text("Choose Imagee"))
          ]),
    );
  }
}