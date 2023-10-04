import 'dart:async';
import 'package:bh_ms/Student_Info/detailpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Student_Attendance extends StatefulWidget {
  final String text,text2,mydate;
  const Student_Attendance({Key? key,required this.text, required this.text2, required this.mydate}) : super(key: key);
  static const routeName = '/homePage';
  @override
  _Student_AttendanceState createState() => _Student_AttendanceState();
}

class _Student_AttendanceState extends State<Student_Attendance> {
  late String id;
  late String usernames;
  late String useremails;
  late String cdate;
  final dateController = TextEditingController();

  double _progress = 0;

  void startTimer() {
    new Timer.periodic(
        Duration(seconds: 1),
            (Timer timer) =>
            setState ((){if (_progress == 1) {
              timer.cancel();
             Navigator.pop(context);
             Navigator.pop(context);
             Navigator.pop(context);
            } else {
              _progress += 0.2;
            }
            },
            ));
  }

  @override
  void initState(){
    super.initState();
    setState(() {
      _progress = 0;
    });
    startTimer();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
    super.dispose();
  }

  Future getPosts() async {
    //DocumentSnapshot variable = await Firestore.instance.collection('user').document(widget.text).get();
    await FirebaseFirestore.instance.collection("user").doc(useremails).snapshots().listen((event) {
      setState(() {
        usernames = event.get("user_name");

      });
    });
  }


  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  navigateToDetail(DocumentSnapshot post){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(post: post, text2: widget.text2, text:  widget.text,)));
  }
  String finalDate = '';

  getCurrentDate(){

    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    setState(() {

      finalDate = formattedDate.toString() ;

    });

  }

  addDate() async{
    Map<String, dynamic> studentData = new Map<String,dynamic>();

    studentData["date"] = finalDate;

    FirebaseFirestore.instance
        .collection('ATTENDANCE').doc(finalDate)
        .set(studentData)
        .whenComplete((){

    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        backgroundColor: Color.fromARGB(255, 27, 2, 59),
        title: Text('${widget.text2} House List',
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
      body:  Stack(
          children: [
      StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection(widget.text2)
              .snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data!.docs[index];
                  int ss = snapshot.data!.docs.length;
                  int gg = 0;
                  for (var i = 0; i <= ss; i++) {
                    Map<String, dynamic> studentData = new Map<String,
                        dynamic>();

                    studentData["student_name"] = snapshot.data!.docs[index]["student_name"];
                    studentData["student_id"] = snapshot.data!.docs[index]["student_id"];
                    studentData["student_course"] = snapshot.data!.docs[index]["student_course"];
                    studentData["date"] = widget.mydate;
                    studentData["status"] = "Present";

                    FirebaseFirestore.instance
                        .collection('ATTENDANCE').doc(widget.mydate).collection(widget.text2).doc(snapshot.data!.docs[index]["student_id"])
                        .set(studentData)
                        .whenComplete(() {
                      gg=gg+1;
                    });

                  }
                  //print("done");
                    return Text(snapshot.data!.docs[index]["student_name"],style: const TextStyle(fontSize: 1.0),);
                      }
                      );


                        }

                        ),
            Center(child:Text('Loading!!!!!!!!! Please Wait.............',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0),)),
            SizedBox(height: 20.0,),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 40.0),
                child: CircularProgressIndicator(
                  value: _progress,
                  strokeWidth: 5,
                  backgroundColor: Colors.white,
                  valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 3, 43, 20)),
                ),
              ),
            )

    ]),
    );


          }

  }
