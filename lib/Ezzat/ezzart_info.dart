import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../HomeScreens/home_page.dart';

class EzzartInfo extends StatefulWidget {
  final String house;
  String std_id,std_course,image,grd_name,std_name,grd_phone;
  final String text;
  EzzartInfo({Key? key,required this.house,required this.text,required this.image, required this.std_id, required this.std_course, required this.grd_name, required this.std_name, required this.grd_phone}) : super(key: key);
  static const routeName = '/addBlogPage';
  @override
  _EzzartInfoState createState() => _EzzartInfoState();
}

class _EzzartInfoState extends State<EzzartInfo> {

  TextEditingController _startController = TextEditingController();
  TextEditingController _endController = TextEditingController();
  TextEditingController _reasonController = TextEditingController();

  String _stdCourseController='Microbiology';

  bool _isLoading = false;
  String _blogId = '';
  int _value = 1;

  File? _image;
  final picker = ImagePicker();

  String Onlydate=DateFormat("yyyy-MM-dd").format(DateTime.now());
  DateTime selectedDate = DateTime.now();
  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());


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
        backgroundColor: Color.fromARGB(255, 3, 2, 59),
        title: Text('New Exeat Form',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          centerTitle: true,
        actions: <Widget>[
          Icon(Icons.navigate_next_outlined)
        ],

        // backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 5.0),
                    Center(child: Text("Student Image",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,),),),
            
            SizedBox(height: 20.0,),

           Padding(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Container(
                                     width: MediaQuery.of(context).size.width,
                                     height: 220,
                                     child: Image.network(widget.image,
                                     fit: BoxFit.fill,
                                        ), 
            ), 
           ),


            SizedBox(height: 20.0),
            Center(child: Text("STUDENT DETAILS",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,),),),
            SizedBox(height: 10.0,),

             Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [

                       Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "  Student ID :  ",style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.brown,
                                      fontSize: 18,
                                      ),
                                  ),
                                  TextSpan(
                                    text: widget.std_id,style: TextStyle(
                                      fontWeight: FontWeight.bold,color: Color.fromARGB(255, 155, 150, 148),
                                      fontSize: 18,
                                      ),
                                  )
                                ]
                              ),
                            ),
                          ],
                        ),

                      Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "  Name :  ",style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.brown,
                                      fontSize: 18,
                                      ),
                                  ),
                                  TextSpan(
                                    text: widget.std_name,style: TextStyle(
                                      fontWeight: FontWeight.bold,color: Colors.black,
                                      fontSize: 18,
                                      ),
                                  )
                                ]
                              ),
                            ),
                          ],
                        ),

                         Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "  Course :  ",style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.brown,
                                      fontSize: 18,
                                      ),
                                  ),
                                  TextSpan(
                                    text: widget.std_course,style: TextStyle(
                                      fontWeight: FontWeight.bold,color: Color.fromARGB(255, 155, 150, 148),
                                      fontSize: 18,
                                      ),
                                  )
                                ]
                              ),
                            ),
                          ],
                        ),

                        Divider(color: Colors.black,),

                        Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "  Guardian Name :  ",style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.brown,
                                      fontSize: 18,
                                      ),
                                  ),
                                  TextSpan(
                                    text: widget.grd_name,style: TextStyle(
                                      fontWeight: FontWeight.bold,color: Colors.black,
                                      fontSize: 18,
                                      ),
                                  )
                                ]
                              ),
                            ),
                          ],
                        ),

                         Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "  Contact :  ",style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.brown,
                                      fontSize: 18,
                                      ),
                                  ),
                                  TextSpan(
                                    text: widget.grd_phone,style: TextStyle(
                                      fontWeight: FontWeight.bold,color: Color.fromARGB(255, 155, 150, 148),
                                      fontSize: 18,
                                      ),
                                  )
                                ]
                              ),
                            ),
                          ],
                        ),

                       
                       Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              primary: Color.fromARGB(255, 31, 5, 148),
              
              ),

              onPressed: (){
                 // Navigator.push(context, MaterialPageRoute(
                   // builder: (context)=> HomePage() 
                    //));
              },
              child: Text("Fill Forms"),
              ),
              ),


                    ],
                  ),
                  ),
              ),
              SizedBox(height: 10,),

              Text("From (Start Date)",style: TextStyle(color: Color.fromARGB(255, 55, 124, 73),fontSize: 18.0,fontWeight: FontWeight.bold,)),

            Container(
              child: TextFormField(
                readOnly: true,
                onTap: () async{
                     var date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2021),
              lastDate: DateTime(2100));
          setState(() {
            selectedDate = date!;
            _startController.text = new DateFormat("yyyy-MM-dd").format(date);
            //String Onlymonth = new DateFormat("MMMM, yyyy").format(date);
            //String Onlyday = new DateFormat("EEEE - dd").format(date);

            /*        dateController.text = '$Onlymonth';
                                dateController1.text = '$Onlyday';
*/
            //print('$Onlymonth');
            //print('$Onlyday');
          });

                },
                style: TextStyle(color: Color.fromARGB(255, 2, 24, 8),fontSize: 20.0,fontWeight: FontWeight.bold,),
                controller: _startController,
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
                  labelText: 'Tap to select Date',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 2, 24, 8), fontSize: 16.0),
                ),
              ),
            ),
            SizedBox(height: 40.0),

            Text("To (End Date)",style: TextStyle(color: Color.fromARGB(255, 55, 124, 73),fontSize: 18.0,fontWeight: FontWeight.bold,)),

            Container(
              child: TextFormField(
                readOnly: true,
                onTap: () async{
                     var date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2021),
              lastDate: DateTime(2100));
          setState(() {
            selectedDate = date!;
            _endController.text = new DateFormat("yyyy-MM-dd").format(date);
            //String Onlymonth = new DateFormat("MMMM, yyyy").format(date);
            //String Onlyday = new DateFormat("EEEE - dd").format(date);

            /*        dateController.text = '$Onlymonth';
                                dateController1.text = '$Onlyday';
*/
            //print('$Onlymonth');
            //print('$Onlyday');
          });
                },
                style: TextStyle(color: Color.fromARGB(255, 2, 24, 8),fontSize: 20.0,fontWeight: FontWeight.bold,),
                controller: _endController,
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
                  labelText: 'Tap to Select Date',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 2, 24, 8), fontSize: 16.0),
                ),
              ),
            ),

            SizedBox(height: 40.0),

            Text("Reason / Comments",style: TextStyle(color: Color.fromARGB(255, 55, 124, 73),fontSize: 18.0,fontWeight: FontWeight.bold,)),

            Container(
              child: TextFormField(
                maxLines: 8,
                style: TextStyle(color: Color.fromARGB(255, 2, 24, 8),fontSize: 20.0,fontWeight: FontWeight.bold,),
                controller: _reasonController,
                cursorColor: Color.fromARGB(255, 2, 24, 8),
                //keyboardType: TextInputType.phone,
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
                  labelText: 'Comments',
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
           if(_startController.text.isEmpty) {
                    //debugPrint('Please make sure student name, image and course is entered');
                    _mostrarAlert('Error','Please make sure you select start Date');
                  } else {
             if (_endController.text.isEmpty) {
               _mostrarAlert('Error', 'Please make sure you select End Date');
             }
             else {
                 if (_reasonController.text.isEmpty) {
                   _reasonController.text = 'None';
                 }
                
                  // _uploadPost(_image, _stdNameController.text, _stdPhoneController.text,_stdCourseController,_stdLocController.text,_gudNameController.text,_gudRelController.text,_gudPhoneController.text);

                  //TODO: FirebaseFirestore create a new record code


                  Map<String, dynamic> studentData = new Map<String,dynamic>();

                  setState(() {
                  _isLoading = true;
                  });


                  studentData["image"] = widget.image;
                 studentData["student_id"] = widget.std_id;
                  studentData["student_name"] = widget.std_name;
                  studentData["student_course"] = widget.std_course;
                  studentData["guardian_name"] = widget.grd_name;
                  studentData["guardian_phone"] = widget.grd_phone;
                  studentData["status"] = "Not In";

                  studentData["from"] = _startController.text;
                  studentData["to"] = _endController.text;
                  studentData["comment"] = _reasonController.text;

                  var now = new DateTime.now();
                  var formatter = new DateFormat('yyyy-MM-dd');
                  String formattedDate = formatter.format(now);
                  print(formattedDate); 

                  FirebaseFirestore.instance
                      .collection('Ezzart').doc('${widget.std_id}-${formattedDate}')
                      .set(studentData)
                      .whenComplete((){
                  setState(() {
                  _isLoading = false;
                  });
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage(text: widget.text,text2: widget.house)));
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } );

                }
                }
                

                  },

                color: Color.fromARGB(255, 27, 5, 129),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                child: Text('Book', style: GoogleFonts.roboto(color: Colors.white, fontSize: 20.0)),
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
