// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../HomeScreens/home_page.dart';

class Attendance_Detail extends StatefulWidget {

  final DocumentSnapshot post;
  String text,text2,myid;
  Attendance_Detail({Key? key, required this.post, required this.text,required this.text2, required this.myid}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Attendance_DetailState createState() => _Attendance_DetailState();
}

// ignore: camel_case_types
class _Attendance_DetailState extends State<Attendance_Detail> {


  TextEditingController _stdNameController = TextEditingController();
  TextEditingController _stdPhoneController = TextEditingController();
  //TextEditingController _stdCourseController = TextEditingController();
  TextEditingController _stdLocController = TextEditingController();
  TextEditingController _gudNameController = TextEditingController();
  TextEditingController _gudPhoneController = TextEditingController();
  TextEditingController _gudRelController = TextEditingController();

  String _stdStatusController='Present';

  bool _isLoading = false;
  String _blogId = '';
  int _value = 1;

  late File _image;
  final picker = ImagePicker();

  Future<void> updatestd(String _stdphone,String _stdloc, String _gudname, String _gudrel, String _gudphone, String id) async {
    await FirebaseFirestore.instance
        .collection("student_info")
        .doc()
        .update({
      "student_phone": _stdphone,
      "student_location": _stdloc,
      "guardian_name": _gudname,
      "guardian_relationship": _gudrel,
      "guardian_phone": _gudphone,
        });
  }

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




  Future _uploadPost(File image, String stdname, String stdphone, String stdcourse, String stdloc, String gudname, String gudphone, String gudrel) async {
    setState(() {
      _isLoading = true;
    });
    DatabaseReference reference = await FirebaseDatabase.instance.reference();
    Reference ref = await FirebaseStorage.instance.ref().child("student_image").child(image.uri.toString() + ".jpg");
    UploadTask uploadTask = ref.putFile(image);
    String downloadUrl = await (await uploadTask).ref.getDownloadURL();
    _blogId = reference.child("student_info").push().key;
    Map data = {
      'image': downloadUrl,
      'student_name': stdname,
      'student_phone': stdphone,
      'student_course': stdcourse,
      'student_location': stdloc,
      'guardian_name': gudname,
      'guardian_Relationship': gudrel,
      'guardian_phone': gudphone,
    };
    reference.child("Student_Info").child(_blogId).set(data).whenComplete(() {
      setState(() {
        _isLoading = false;
      });

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(text: '', text2: '',)), (route) => false);
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
          onPressed: (){
          Navigator.pop(context);
          },
    ),
    backgroundColor: Color.fromARGB(255, 31, 102, 33),
    title: Text('Student Attendace Update',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 40.0, left: 25.0, right: 25.0),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Center(child:
                  Text('Student Info', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                      ),

            SizedBox(height: 20.0),

            Container(

              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 2, 43, 19),fontSize: 20.0,fontWeight: FontWeight.bold,),
                enabled: false,
                cursorColor: Color.fromARGB(255, 2, 43, 19),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 43, 19),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 43, 19),
                    ),
                  ),
                  labelText: widget.post.data()!["student_id"],
                  labelStyle: TextStyle(color: Color.fromARGB(255, 2, 43, 19), fontSize: 20.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(

              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 2, 43, 19),fontSize: 20.0,fontWeight: FontWeight.bold,),
                controller: _stdNameController,
                enabled: false,
                cursorColor: Color.fromARGB(255, 2, 43, 19),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 43, 19),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 43, 19),
                    ),
                  ),
                  labelText: widget.post.data()!["student_name"],
                  labelStyle: TextStyle(color: Color.fromARGB(255, 2, 43, 19), fontSize: 20.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 2, 43, 19),fontSize: 20.0,fontWeight: FontWeight.bold,),
                controller: _stdPhoneController,
                cursorColor: Color.fromARGB(255, 2, 43, 19),
                enabled: false,
                keyboardType: TextInputType.text,

                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 43, 19),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 43, 19),
                    ),
                  ),
                  labelText: widget.post.data()!["student_course"],
                  labelStyle: TextStyle(color: Color.fromARGB(255, 2, 43, 19), fontSize: 20.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),

   Row(children: [
        Text("Select Status: ",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(255, 2, 43, 19)),),

        SizedBox(width: 20.0,),
        DropdownButton(


            value: _value,
            items: [
              DropdownMenuItem(
                child: Text("Present",style: TextStyle(fontSize: 20.0),),
                value: 1,
              ),
              DropdownMenuItem(
                child: Text("Absent",style: TextStyle(fontSize: 20.0),),
                value: 2,
              ),
            ],
            onChanged: (value) {
              setState(() {
                _value = value as int;
                if(value==1){
                  _stdStatusController="Present";
                  print('P');
                }
                if(value==2){
                  _stdStatusController="Absent";
                  print('A');
                }

              });
            }),

      ],),
            SizedBox(height: 20.0,),

            Container(
              height: 50.0,
              width: double.infinity,
              child: FlatButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();

                  Map<String, dynamic> studentData = new Map<String,dynamic>();

                  setState(() {
                    _isLoading = true;
                  });


                  studentData["status"] = _stdStatusController;

                  FirebaseFirestore.instance
                      .collection("ATTENDANCE").doc(widget.myid).collection(widget.text2).doc(widget.post.data()!["student_id"])
                      .update(studentData)
                      .whenComplete((){
                 setState(() {
                      _isLoading = false;
                    });
                    Navigator.pop(context);
                  } );

                  // updatestd(_stdPhoneController.text,_stdLocController.text,_gudNameController.text,_gudRelController.text,_gudPhoneController.text, widget.post.data()["student_name"]);
                    /*   setState(() {
                         _isLoading=false;
                       });
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
*/
                  },

                color: Color.fromARGB(255, 13, 85, 51),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                child: Text('Update Student Info', style: GoogleFonts.roboto(color: Colors.white, fontSize: 20.0)),
              ),
            ),
            SizedBox(height: 20.0),

            _isLoading ? Container(
              margin: EdgeInsets.symmetric(horizontal: 50.0),
              child: Center(
                child: LinearProgressIndicator(minHeight: 5.0),
              ),
            ) : Container(width: 0.0, height: 0.0)
          ],
        ),
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
