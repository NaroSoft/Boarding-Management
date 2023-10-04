import 'dart:io';
import 'package:bh_ms/Ezzat/ezzart_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../HomeScreens/home_page.dart';

class AddEzzatStudent extends StatefulWidget {
  final String house;
  final String text;
  const AddEzzatStudent({Key? key,required this.house,required this.text}) : super(key: key);
  static const routeName = '/addBlogPage';
  @override
  _AddEzzatStudentState createState() => _AddEzzatStudentState();
}

class _AddEzzatStudentState extends State<AddEzzatStudent> {

  TextEditingController _stdNameController = TextEditingController();
  TextEditingController _stdPhoneController = TextEditingController();
  TextEditingController _stdIDController = TextEditingController();
  TextEditingController _stdLocController = TextEditingController();
  TextEditingController _gudNameController = TextEditingController();
  TextEditingController _gudPhoneController = TextEditingController();
  TextEditingController _gudRelController = TextEditingController();

  String _stdCourseController='General Arts';

  bool _isLoading = false;
  String _blogId = '';
  int _value = 1;

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery,);
    File compressedFile = await FlutterNativeImage.compressImage(pickedFile!.path,
      quality: 25,);
    setState(() {
     // _image = File(pickedFile.path);
      _image=compressedFile;
    });
  }

  Future getImages() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera,);
    File compressedFile = await FlutterNativeImage.compressImage(pickedFile!.path,
      quality: 25,);
    setState(() {
     // _image = File(pickedFile.path);
      _image=compressedFile;
    });
  }

  Future<File?> compressFile(File file) async{
    File compressedFile = await FlutterNativeImage.compressImage(file.path,
      quality: 5,);
    _image=compressedFile;
    return _image;
  }

  @override
void initState() {
  super.initState();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
          IconButton(
              icon: Icon(Icons.arrow_back),
            onPressed: (){
                Navigator.pop(context);
            },
          ),
        backgroundColor: Color.fromARGB(255, 3, 2, 58),
        title: Text('Select Student',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          centerTitle: true,
        actions: <Widget>[
          Icon(Icons.navigate_next_outlined)
        ],

        // backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection(widget.house).snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: double.infinity,
                  child: Row(

                    children: <Widget>[
                      Flexible(child: ListTile(
                    onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EzzartInfo(
                      house: widget.house,
                      text: widget.text, 
                      image: snapshot.data!.docs[index].data()["image"],
                      std_id: snapshot.data!.docs[index].data()["student_id"],
                      std_name: snapshot.data!.docs[index].data()["student_name"],
                      std_course: snapshot.data!.docs[index].data()["student_course"],
                      grd_name: snapshot.data!.docs[index].data()["guardian_name"],
                      grd_phone: snapshot.data!.docs[index].data()["guardian_phone"],
                      )));
 
                    },
                      title:  SizedBox(
                        height: MediaQuery.of(context).size.height*0.15,
                        width: MediaQuery.of(context).size.width,
                        child:  Card(
                          elevation: 0,
                          child: Row(
                            children: <Widget>[
                              new Container(

                                child: Image.network(snapshot.data!.docs[index].data()["image"],height: MediaQuery.of(context).size.width*0.3,width: MediaQuery.of(context).size.width*0.3,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5,right: 5,top: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[

                                                  SizedBox(width: 5),
                                                  Text(snapshot.data!.docs[index].data()["student_name"], style: TextStyle(color: Color.fromARGB(255, 2, 27, 3),fontWeight: FontWeight.w500, fontSize: 18.0,fontFamily: 'Roboto-Black'),)
                                                ],
                                              ),

                                             SizedBox(height:20.0),

                                              Text(snapshot.data!.docs[index].data()["student_course"],style: TextStyle(fontWeight: FontWeight.w700,fontSize:18.0,color: Colors.black26),),

                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                  ),
                      ),
              ],
                  ),
                  padding: EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    //    color: Colors.black,
                  ),
                ),
              );
            },
          );
        },

     
      ),
    );
  }

void _mostrarAlert(String title, String message){
  AlertDialog alertDialog=AlertDialog(
    title: Text(title),
    content: Text(message),
  );
  showDialog(context: context,builder: (_)=>alertDialog);
}
}
