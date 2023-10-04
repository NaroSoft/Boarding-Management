import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../HomeScreens/home_page.dart';

class AddStudent extends StatefulWidget {
  final String house;
  final String text;
  const AddStudent({Key? key,required this.house,required this.text}) : super(key: key);
  static const routeName = '/addBlogPage';
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {

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
        backgroundColor: Color.fromARGB(255, 34, 3, 73),
        title: Text('New Student Info',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        /* actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.filter_b_and_w,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],*/

        // backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 40.0, left: 25.0, right: 25.0),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                /*  Center(child:
                  Text('New Student Forms', style: GoogleFonts.bubblegumSans(color: Color.fromARGB(255, 2, 24, 8), fontSize: 32.0, fontWeight: FontWeight.bold)),
                      ),*/
        /* FlatButton(
                    onPressed: getImage,
                    color: Color.fromARGB(255, 2, 24, 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    child: Text('Add Image', style: GoogleFonts.roboto(color: Colors.white)),
                  )*/
                ],
              ),
            ),
            SizedBox(height: 30.0),
            _image == (null) ? Container(
              color: Colors.white24,
              width: MediaQuery.of(context).size.width, height: 300.0) : ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image(
                width: MediaQuery.of(context).size.width,
                height: 300.0,
                image: FileImage(_image!),
                //color: Colors.blueGrey,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
            SizedBox(height: 10.0),

            Row(
              children: [
                SizedBox(width: 100.0,),
              FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 6, 1, 26),
                  child: Icon(Icons.camera_alt,color: Colors.white),
                  heroTag: 1,
                  onPressed: (){
                   getImages();
                  }),

                SizedBox(width: 20.0,),
                FloatingActionButton(
                    backgroundColor: Color.fromARGB(189, 50, 17, 110),
                    child: Icon(Icons.add_photo_alternate_outlined,color: Colors.white,),
                    heroTag: 2,
                    onPressed: (){
                      getImage();
                    }),

              ],),

            SizedBox(height: 20.0),
            Center(child: Text("STUDENT DETAILS",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,),),),
            SizedBox(height: 10.0,),
            Container(
              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 2, 24, 8),fontSize: 20.0,fontWeight: FontWeight.bold,),
                controller: _stdIDController,
                cursorColor: Color.fromARGB(255, 2, 24, 8),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 24, 8),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 24, 8),
                    ),
                  ),
                  labelText: 'Student ID',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 2, 24, 8), fontSize: 16.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 2, 24, 8),fontSize: 20.0,fontWeight: FontWeight.bold,),
                controller: _stdNameController,
                cursorColor: Color.fromARGB(255, 2, 24, 8),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 24, 8),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 24, 8),
                    ),
                  ),
                  labelText: 'Full Name',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 2, 24, 8), fontSize: 16.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 2, 24, 8),fontSize: 20.0,fontWeight: FontWeight.bold,),
                controller: _stdPhoneController,
                cursorColor: Color.fromARGB(255, 2, 24, 8),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 24, 8),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 24, 8),
                    ),
                  ),
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 2, 24, 8), fontSize: 16.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),

      Row(children: [
        Text("Select Course: ",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(255, 2, 24, 8)),),
        SizedBox(width: 10.0,),
        DropdownButton(

            value: _value,
            items: [
              DropdownMenuItem(
                child: Text("Microbiology",style: TextStyle(fontSize: 20.0),),
                value: 1,
              ),
              DropdownMenuItem(
                child: Text("General Arts",style: TextStyle(fontSize: 20.0),),
                value: 2,
              ),
              DropdownMenuItem(
                  child: Text("Science",style: TextStyle(fontSize: 20.0),),
                  value: 3
              ),
              DropdownMenuItem(
                  child: Text("Business",style: TextStyle(fontSize: 20.0),),
                  value: 4
              ),
              DropdownMenuItem(
                  child: Text("Visual Arts",style: TextStyle(fontSize: 20.0),),
                  value: 5
              ),
             
            ],
            onChanged: (value) {
              setState(() {
                _value = value as int;
                if(value==1){
                  _stdCourseController="General Arts";
                }
                else if(value==2){
                  _stdCourseController="Science";
                }
                else if(value==3){
                  _stdCourseController="Business";
                }
                else if(value==4){
                  _stdCourseController="Business";
                }
                else {
                  _stdCourseController="Visual Arts";
                }
               
              });
            }),

      ],),

            SizedBox(height: 20.0),
            Container(
              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 2, 24, 8),fontSize: 20.0,fontWeight: FontWeight.bold,),
                controller: _stdLocController,
                textCapitalization: TextCapitalization.words,
                cursorColor: Color.fromARGB(255, 2, 24, 8),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 24, 8),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 24, 8),
                    ),
                  ),
                  labelText: 'Place or Location of Residence',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 2, 24, 8), fontSize: 16.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),

            Center(child: Text("GUARDIAN DETAILS",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,),),),

            SizedBox(height: 10.0,),

            Container(
              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 2, 24, 8),fontSize: 20.0,fontWeight: FontWeight.bold,),
                controller: _gudNameController,
                textCapitalization: TextCapitalization.words,
                cursorColor: Color.fromARGB(255, 2, 24, 8),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 24, 8),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 24, 8),
                    ),
                  ),
                  labelText: 'Full Name',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 2, 24, 8), fontSize: 16.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),

            Container(
              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 2, 24, 8),fontSize: 20.0,fontWeight: FontWeight.bold,),
                controller: _gudRelController,
                textCapitalization: TextCapitalization.words,
                cursorColor: Color.fromARGB(255, 2, 24, 8),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 24, 8),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 24, 8),
                    ),
                  ),
                  labelText: 'Relationship',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 2, 24, 8), fontSize: 16.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),

            Container(
              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 2, 24, 8),fontSize: 20.0,fontWeight: FontWeight.bold,),
                controller: _gudPhoneController,
                cursorColor: Color.fromARGB(255, 2, 24, 8),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 24, 8),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 24, 8),
                    ),
                  ),
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 2, 24, 8), fontSize: 16.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),

            Container(
              height: 50.0,
              width: double.infinity,
              child: FlatButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
           if(_stdNameController.text.isEmpty && _stdCourseController.isEmpty && _image == null) {
                    debugPrint('Please make sure student name, image and course is entered');
                    _mostrarAlert('Error','Please make sure student name, image and course is Entered');
                  } else {
             if (_stdNameController.text.isEmpty) {
               _mostrarAlert('Error', 'Student Name is Blanck');
             } else {
               if (_image == null) {
                 _mostrarAlert('Error', 'Student image is Blanck');
               } else {
                 if (_stdPhoneController.text.isEmpty) {
                   _stdPhoneController.text = 'None';
                 }
                 if (_stdLocController.text.isEmpty) {
                   _stdLocController.text = 'None';
                 }
                 if (_gudNameController.text.isEmpty) {
                   _gudNameController.text = 'None';
                 }
                 if (_gudPhoneController.text.isEmpty) {
                   _gudPhoneController.text = 'None';
                 }
                 if (_gudRelController.text.isEmpty) {
                   _gudRelController.text = 'None';
                 }

                  // _uploadPost(_image, _stdNameController.text, _stdPhoneController.text,_stdCourseController,_stdLocController.text,_gudNameController.text,_gudRelController.text,_gudPhoneController.text);

                  //TODO: FirebaseFirestore create a new record code


                  Map<String, dynamic> studentData = new Map<String,dynamic>();

                  setState(() {
                  _isLoading = true;
                  });

                  Reference ref = await FirebaseStorage.instance.ref().child("student_image").child(_image!.uri.toString() + ".jpg");
                  UploadTask uploadTask = ref.putFile(_image!);
                  String downloadUrl = await (await uploadTask).ref.getDownloadURL();

                  studentData["image"] = downloadUrl;
                 studentData["student_id"] = _stdIDController.text;
                  studentData["student_name"] = _stdNameController.text;
                  studentData["student_phone"] = _stdPhoneController.text;
                  studentData["student_course"] = _stdCourseController;
                  studentData["student_location"] = _stdLocController.text;
                  studentData["guardian_name"] = _gudNameController.text;
                  studentData["guardian_relationship"] = _gudRelController.text;
                  studentData["guardian_phone"] = _gudPhoneController.text;

                  FirebaseFirestore.instance
                      .collection(widget.house).doc(_stdIDController.text)
                      .set(studentData)
                      .whenComplete((){
                  setState(() {
                  _isLoading = false;
                  });
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage(text: widget.text,text2: widget.house)));
                    Navigator.pop(context);
                  } );

                }
                }
                }

                  },

                color: Color.fromARGB(255, 32, 9, 126),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                child: Text('Add Student', style: GoogleFonts.roboto(color: Colors.white, fontSize: 20.0)),
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
