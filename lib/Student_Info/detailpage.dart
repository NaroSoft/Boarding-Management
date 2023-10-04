import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../HomeScreens/home_page.dart';

class DetailPage extends StatefulWidget {

  final DocumentSnapshot post;
  String text2,text;
  DetailPage({required this.post,required this.text2,required this.text});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {


  TextEditingController _stdNameController = TextEditingController();
  TextEditingController _stdPhoneController = TextEditingController();
  //TextEditingController _stdCourseController = TextEditingController();
  TextEditingController _stdLocController = TextEditingController();
  TextEditingController _gudNameController = TextEditingController();
  TextEditingController _gudPhoneController = TextEditingController();
  TextEditingController _gudRelController = TextEditingController();

  String _stdCourseController='Select Student Course';

  bool _isLoading = false;
  String _blogId = '';
  int _value = 1;

  late File _image;
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




  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    leading:
    IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: (){
    Navigator.of(context).pop();
    },
    ),
    backgroundColor: Color.fromARGB(255, 17, 1, 39),
    title: Text('Update Student Info',
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
              margin: EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(child:
                  Text('Update Student Forms', style: GoogleFonts.bubblegumSans(color: Color.fromARGB(255, 3, 31, 12), fontSize: 25.0, fontWeight: FontWeight.bold)),
                      ),
        /* FlatButton(
                    onPressed: getImage,
                    color: Color.fromARGB(255, 3, 71, 25),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    child: Text('Add Image', style: GoogleFonts.roboto(color: Colors.white)),
                  )*/
                ],
              ),
            ),

            SizedBox(height: 30.0),
           /* _image == null ? Container(width: MediaQuery.of(context).size.width, height: 300.0) : ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image(
                width: MediaQuery.of(context).size.width,
                height: 300.0,
                image: FileImage(_image),
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
                heroTag: 1,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.camera_alt,color: Colors.white,),
                  onPressed: (){
                   getImages();
                  }),

                SizedBox(width: 20.0,),
                FloatingActionButton(
                  heroTag: 2,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.add_photo_alternate_outlined,color: Colors.white,),
                    onPressed: (){
                      getImage();
                    }),

              ],),

            SizedBox(height: 20.0),*/

            Center(child: Text("STUDENT DETAILS",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,),),),
            SizedBox(height: 10.0,),

            Container(

              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 3, 71, 25),fontSize: 20.0,fontWeight: FontWeight.bold,),
                enabled: false,
                cursorColor: Color.fromARGB(255, 3, 71, 25),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 3, 71, 25),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 3, 71, 25),
                    ),
                  ),
                  labelText: widget.post.data()!["student_id"],
                  labelStyle: TextStyle(color: Color.fromARGB(255, 3, 71, 25), fontSize: 20.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(

              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 3, 71, 25),fontSize: 20.0,fontWeight: FontWeight.bold,),
                controller: _stdNameController,

                enabled: false,
                cursorColor: Color.fromARGB(255, 3, 71, 25),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 3, 71, 25),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 3, 71, 25),
                    ),
                  ),
                  labelText: widget.post.data()!["student_name"],
                  labelStyle: TextStyle(color: Color.fromARGB(255, 3, 71, 25), fontSize: 20.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 3, 71, 25),fontSize: 20.0,fontWeight: FontWeight.bold,),
                controller: _stdPhoneController,
                cursorColor: Color.fromARGB(255, 3, 71, 25),
                keyboardType: TextInputType.phone,

                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 3, 71, 25),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 3, 71, 25),
                    ),
                  ),
                  labelText: widget.post.data()!["student_phone"],
                  labelStyle: TextStyle(color: Color.fromARGB(255, 3, 71, 25), fontSize: 20.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),

      /*Row(children: [
        Text("Select Course: ",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(255, 3, 71, 25)[100]),),

        SizedBox(width: 10.0,),
        DropdownButton(

            value: _value,
            items: [
              DropdownMenuItem(
                child: Text("Select Student Course",style: TextStyle(fontSize: 20.0),),
                value: 1,
              ),
              DropdownMenuItem(
                child: Text("General Arts",style: TextStyle(fontSize: 20.0),),
                value: 2,
              ),
              DropdownMenuItem(
                child: Text("General Science",style: TextStyle(fontSize: 20.0),),
                value: 3,
              ),
              DropdownMenuItem(
                  child: Text("Business",style: TextStyle(fontSize: 20.0),),
                  value: 4,
              ),
              DropdownMenuItem(
                  child: Text("Visual Arts",style: TextStyle(fontSize: 20.0),),
                  value: 5,
              )
            ],
            onChanged: (value) {
              setState(() {
                _value = value;
                if(value==1){
                  _stdCourseController="Select Student Course";
                }
                if(value==2){
                  _stdCourseController="General Arts";
                }
                else if(value==3){
                  _stdCourseController="General Science";
                }
                else if(value==4){
                  _stdCourseController="Business";
                }
                else{
                  _stdCourseController="Visual Arts";
                }
              });
            }),

      ],),
*/
            SizedBox(height: 20.0),
            Container(
              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 3, 71, 25),fontSize: 20.0,fontWeight: FontWeight.bold,),
                controller: _stdLocController,
                textCapitalization: TextCapitalization.words,
                cursorColor: Color.fromARGB(255, 3, 71, 25),
                keyboardType: TextInputType.text,

                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 3, 71, 25),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 3, 71, 25),
                    ),
                  ),
                  labelText: widget.post.data()!["student_location"],
                  labelStyle: TextStyle(color: Color.fromARGB(255, 3, 71, 25), fontSize: 20.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),

            Center(child: Text("GUARDIAN DETAILS",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,),),),

            SizedBox(height: 10.0,),

            Container(
              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 3, 71, 25),fontSize: 20.0,fontWeight: FontWeight.bold,),
                controller: _gudNameController,
                textCapitalization: TextCapitalization.words,
                cursorColor: Color.fromARGB(255, 3, 71, 25),
                keyboardType: TextInputType.text,

                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 3, 71, 25),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 3, 71, 25),
                    ),
                  ),
                  labelText: widget.post.data()!["guardian_name"],
                  labelStyle: TextStyle(color: Color.fromARGB(255, 3, 71, 25), fontSize: 20.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),

            Container(
              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 3, 71, 25),fontSize: 20.0,fontWeight: FontWeight.bold,),
                controller: _gudRelController,
                textCapitalization: TextCapitalization.words,
                cursorColor: Color.fromARGB(255, 3, 71, 25),
                keyboardType: TextInputType.text,

                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 3, 71, 25),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 3, 71, 25),
                    ),
                  ),
                  labelText: widget.post.data()!["guardian_relationship"],
                  labelStyle: TextStyle(color: Color.fromARGB(255, 3, 71, 25), fontSize: 20.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),

            Container(
              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 3, 71, 25),fontSize: 20.0,fontWeight: FontWeight.bold,),
                controller: _gudPhoneController,
                cursorColor: Color.fromARGB(255, 3, 71, 25),
                keyboardType: TextInputType.phone,

                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 3, 71, 25),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 3, 71, 25),
                    ),
                  ),
                  labelText: widget.post.data()!["guardian_phone"],
                  labelStyle: TextStyle(color: Color.fromARGB(255, 3, 71, 25), fontSize: 20.0),
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


                          if (_stdPhoneController.text.isEmpty) {
                            _stdPhoneController.text = widget.post.data()!["student_phone"];
                          }
                          if (_stdLocController.text.isEmpty) {
                            _stdLocController.text = widget.post.data()!["student_location"];
                          }
                          if (_gudNameController.text.isEmpty) {
                            _gudNameController.text = widget.post.data()!["guardian_name"];
                          }
                          if (_gudPhoneController.text.isEmpty) {
                            _gudPhoneController.text = widget.post.data()!["guardian_phone"];
                          }
                          if (_gudRelController.text.isEmpty) {
                            _gudRelController.text = widget.post.data()!["guardian_relationship"];
                          }

                  Map<String, dynamic> studentData = new Map<String,dynamic>();

                  setState(() {
                    _isLoading = true;
                  });

                 // StorageReference ref = await FirebaseStorage.instance.ref().child("student_image").child(_image.uri.toString() + ".jpg");
                 // StorageUploadTask uploadTask = ref.putFile(_image);
                 // String downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

                 // studentData["image"] = downloadUrl;
                 // studentData["student_name"] = _stdNameController.text;
                  studentData["student_phone"] = _stdPhoneController.text;
                  //studentData["student_course"] = _stdCourseController;
                  studentData["student_location"] = _stdLocController.text;
                  studentData["guardian_name"] = _gudNameController.text;
                  studentData["guardian_relationship"] = _gudRelController.text;
                  studentData["guardian_phone"] = _gudPhoneController.text;

                  FirebaseFirestore.instance
                      .collection(widget.text2).doc(widget.post.data()!["student_id"])
                      .update(studentData)
                      .whenComplete((){
                 setState(() {
                      _isLoading = false;
                      Route route= MaterialPageRoute(builder: (context)=>HomePage(text2: widget.text2,text: widget.text));
                Navigator.pushReplacement(context, route);
                    });
                  
                  } );

                  // updatestd(_stdPhoneController.text,_stdLocController.text,_gudNameController.text,_gudRelController.text,_gudPhoneController.text, widget.post.data()["student_name"]);
                    /*   setState(() {
                         _isLoading=false;
                       });
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
*/
                  },

                color: Color.fromARGB(255, 30, 10, 104),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                child: Text('Update Student Info', style: GoogleFonts.roboto(color: Colors.white, fontSize: 20.0)),
              ),
            ),
            SizedBox(height: 20.0),

            Container(
              height: 50.0,
              width: double.infinity,
              child: FlatButton(
                onPressed: () async {
                  //FocusScope.of(context).unfocus();

                  setState(() {
                    _isLoading = true;
                  });

                  FirebaseFirestore.instance
                      .collection(widget.text2).doc(widget.post.data()!["student_id"])
                      .delete()
                      .whenComplete((){
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(text: widget.text, text2: widget.text2,)), (route) => false);
                  } );

                },

                color: Color.fromARGB(255, 141, 28, 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                child: Text('Delete Student', style: GoogleFonts.roboto(color: Colors.white, fontSize: 20.0)),
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
