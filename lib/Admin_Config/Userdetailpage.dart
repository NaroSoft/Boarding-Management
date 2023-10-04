import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';


// ignore: must_be_immutable
class UserDetailPage extends StatefulWidget {

  final DocumentSnapshot post;
  String text2;
  UserDetailPage({Key? key, required this.post,required this.text2}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {

  //TextEditingController _stdCourseController = TextEditingController();
  final TextEditingController _gudNameController = TextEditingController();
  final TextEditingController _gudPhoneController = TextEditingController();
  final TextEditingController _gudRelController = TextEditingController();

  final String _stdCourseController='Select Student Course';

  bool _isLoading = false;
  final String _blogId = '';
  final int _value = 1;

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
    icon: const Icon(Icons.arrow_back),
    onPressed: (){
    Navigator.of(context).pop();
    },
    ),
    backgroundColor: Color.fromARGB(255, 35, 126, 40),
    centerTitle: true,
    title: const Text('User Details',
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
        padding: const EdgeInsets.only(top: 40.0, left: 25.0, right: 25.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(child:
                  Text('User Info', style: GoogleFonts.bubblegumSans(color: Color.fromARGB(255, 2, 54, 9), fontSize: 32.0, fontWeight: FontWeight.bold)),
                      ),
        /* FlatButton(
                    onPressed: getImage,
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    child: Text('Add Image', style: GoogleFonts.roboto(color: Colors.white)),
                  )*/
                ],
              ),
            ),

            const SizedBox(height: 30.0),

            Container(

              child: TextFormField(
                style: const TextStyle(color: Color.fromARGB(255, 1, 59, 19),fontSize: 20.0,fontWeight: FontWeight.bold,),
                enabled: false,
                cursorColor: Colors.blueAccent,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                  ),
                  labelText: widget.post.data()!["user_name"],
                  labelStyle: TextStyle(color: Color.fromARGB(255, 4, 122, 42), fontSize: 20.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(

              child: TextFormField(
                style: const TextStyle(color: Colors.blueAccent,fontSize: 20.0,fontWeight: FontWeight.bold,),
                //controller: _stdNameController,
                enabled: false,
                cursorColor: Colors.blueAccent,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                  ),
                  labelText: "Email: "+widget.post.data()!["user_email"],
                  labelStyle: TextStyle(color: Color.fromARGB(255, 4, 122, 42), fontSize: 20.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(

              child: TextFormField(
                style: const TextStyle(color: Colors.blueAccent,fontSize: 20.0,fontWeight: FontWeight.bold,),
                //controller: _stdNameController,
                enabled: false,
                cursorColor: Colors.blueAccent,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                  ),
                  labelText: "Phone: "+widget.post.data()!["user_phone"],
                  labelStyle: TextStyle(color: Color.fromARGB(255, 4, 122, 42), fontSize: 20.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(

              child: TextFormField(
                style: const TextStyle(color: Colors.blueAccent,fontSize: 20.0,fontWeight: FontWeight.bold,),
                //controller: _stdNameController,
                enabled: false,
                cursorColor: Colors.blueAccent,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                  ),
                  labelText: "House: "+widget.post.data()!["user_house"],
                  labelStyle: TextStyle(color: Color.fromARGB(255, 4, 122, 42), fontSize: 20.0),
                ),
              ),
            ),

            const SizedBox(height: 20.0),

            Container(

              child: TextFormField(
                style: const TextStyle(color: Colors.blueAccent,fontSize: 20.0,fontWeight: FontWeight.bold,),
                //controller: _stdNameController,
                enabled: false,
                cursorColor: Colors.blueAccent,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                  ),
                  labelText: "Status: "+widget.post.data()!["user_status"],
                  labelStyle: TextStyle(color: Color.fromARGB(255, 4, 122, 42), fontSize: 20.0),
                ),
              ),
            ),

            const SizedBox(height: 30.0),

            Container(
              height: 50.0,
              width: double.infinity,
              child: FlatButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();

                  setState(() {
                    _isLoading = true;
                  });

                  FirebaseFirestore.instance
                      .collection("user").doc(widget.post.data()!["user_email"])
                      .delete()
                      .whenComplete((){
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.pop(context);
                  } );

                },

                color: Color.fromARGB(255, 90, 37, 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                child: Text('Delete User', style: GoogleFonts.roboto(color: Colors.white, fontSize: 20.0)),
              ),
            ),
            const SizedBox(height: 20.0),
            _isLoading ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 50.0),
              child: const Center(
                child: const LinearProgressIndicator(minHeight: 5.0,color: Color.fromARGB(255, 3, 65, 5),backgroundColor: Color.fromARGB(255, 78, 10, 5)),
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
