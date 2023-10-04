import 'package:bh_ms/Student_Info/detailpage.dart';
import 'package:bh_ms/attendance/attendance_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Student_Info/add_student.dart';
import '../Authentication/authentication_page.dart';
import 'House_Login_Home.dart';

class Matron_Login_Home extends StatefulWidget {
  final String text,text2;
  const Matron_Login_Home({Key? key,required this.text, required this.text2}) : super(key: key);
  static const routeName = '/homePage';
  @override
  _Matron_Login_HomeState createState() => _Matron_Login_HomeState();
}


class _Matron_Login_HomeState extends State<Matron_Login_Home> {
  String id="";
  String usernames="";
  String useremails="";

 String ? Onlydate= DateFormat("yyyy-MM-dd").format(DateTime.now());

  DateTime selectedDate = DateTime.now();
  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());

  int ? a=0,b=0,c=0,d=0,e=0;


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
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(post: post,text2: widget.text2, text: widget.text)));
  }

  


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    e=0;
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 35, 126, 40),
        centerTitle: true,
        leading:  IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.white70,
            size: 30.0,
          ),
          onPressed: () {
            _firebaseAuth.signOut();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AuthenticationPage()), (route) => false);
          },
        ),
        title: Text('${widget.text}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.calendar_month,
              color: Color.fromARGB(255, 236, 230, 230),
              size: 30.0,
            ),
            onPressed: () async{
               var date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2021),
                lastDate: DateTime(2100));
            setState(() {
              selectedDate = date!;
              Onlydate = new DateFormat("yyyy-MM-dd").format(date);
              //e=0;
              //String Onlymonth = new DateFormat("MMMM, yyyy").format(date);
              //String Onlyday = new DateFormat("EEEE - dd").format(date);

              /*        dateController.text = '$Onlymonth';
                                dateController1.text = '$Onlyday';
*/
              //print('$Onlymonth');
              //print('$Onlyday');
            });
              e=0;
               },
          )
        ],
        // backgroundColor: Colors.black,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Color.fromARGB(255, 5, 49, 18),
        child: IconButton(
          icon: Icon(Icons.calculate,color: Colors.white,),
          iconSize: 30.0,
          onPressed: ()async {
            setState(() {
               e=a!+b!+c!+d!;
            });
           
          },),
      ),


      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 40.0, left: 25.0, right: 25.0),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Divider(height: 5.0,color: Color.fromARGB(255, 5, 66, 25),thickness: 5.0,),
            SizedBox(height: 5.0,),
            Center(child:
            Text("Attendance on ${Onlydate}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.black),
            ),
            ),
            SizedBox(height: 5.0,),
            Divider(height: 5.0,color: Color.fromARGB(255, 5, 66, 25),thickness: 5.0,),

            SizedBox(height: 20.0,),
            Center(child:
            Text(" BEETHEM HOUSE ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.0,color: Colors.white,backgroundColor: Color.fromARGB(255, 5, 56, 16)),
            ),
            ),
            SizedBox(height: 10.0,),
            Row(children: [
              Text("Total Students: ",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(137, 2, 43, 18),),),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('BEETHEM').snapshots(),
                //  stream: FirebaseFirestore.instance.collection('ATTENDANCE').doc(Onlydate).collection(widget.text2).where('status',isEqualTo: 'Absent').snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Text("0",style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.bold),)
                        : Text(snapshot.data!.docs.length.toString(),style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.bold),
                    );
                  }
              ),
            ],),

            SizedBox(height: 10.0,),
            Row(children: [
              Text("Students Present: ",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(137, 2, 43, 18),),),
              StreamBuilder<QuerySnapshot>(
                  //stream: FirebaseFirestore.instance.collection('ATTENDANCE').doc(Onlydate).collection('BEETHEM').snapshots(),
                  stream: FirebaseFirestore.instance.collection('ATTENDANCE').doc(Onlydate).collection('BEETHEM').where('status',isEqualTo: 'Present').snapshots(),
                  builder: (context, snapshot) {

                    if(snapshot.hasData) {
                      e=0;
                      a = int.tryParse(snapshot.data!.docs.length.toString());
                      e=e!+a!;
                    }
                      else{
                        a=0;
                        e=e!+a!;
                    }

                    return !snapshot.hasData
                        ? Text("0",style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.bold),)
                        :  Text(snapshot.data!.docs.length.toString(),style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.bold),
                    );
                  }
              ),
            ],),


            SizedBox(height: 20.0,),
            Center(child:
            Text(" FOLSON HOUSE ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.0,color: Colors.white,backgroundColor: Color.fromARGB(255, 5, 56, 16)),
            ),
            ),
            SizedBox(height: 10.0,),
            Row(children: [
              Text("Total Students: ",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(137, 2, 43, 18),),),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('FOLSON').snapshots(),
                  //  stream: FirebaseFirestore.instance.collection('ATTENDANCE').doc(Onlydate).collection(widget.text2).where('status',isEqualTo: 'Absent').snapshots(),
                  builder: (context, snapshot) {

                    return !snapshot.hasData
                        ? Text("0",style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.bold),)
                        : Text(snapshot.data!.docs.length.toString(),style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.bold),
                    );
                  }
              ),
            ],),

            SizedBox(height: 10.0,),
            Row(children: [
              Text("Students Present: ",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(137, 2, 43, 18),),),
              StreamBuilder<QuerySnapshot>(
                //stream: FirebaseFirestore.instance.collection('ATTENDANCE').doc(Onlydate).collection('BEETHEM').snapshots(),
                  stream: FirebaseFirestore.instance.collection('ATTENDANCE').doc(Onlydate).collection('FOLSON').where('status',isEqualTo: 'Present').snapshots(),
                  builder: (context, snapshot) {

                      if (snapshot.hasData) {
                        b = int.tryParse(snapshot.data!.docs.length.toString());
                        e=e!+b!;
                      }
                      else {
                        b = 0;
                        e=e!+b!;
                      }

                    return !snapshot.hasData
                        ? Text("0",style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.bold),)
                        : Text(snapshot.data!.docs.length.toString(),style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.bold),
                    );
                  }
              ),
            ],),


            SizedBox(height: 20.0,),
            Center(child:
            Text(" PREMPEH HOUSE ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.0,color: Colors.white,backgroundColor: Color.fromARGB(255, 5, 56, 16)),
            ),
            ),
            SizedBox(height: 10.0,),
            Row(children: [
              Text("Total Students: ",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(137, 2, 43, 18),),),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('PREMPEH').snapshots(),
                  //  stream: FirebaseFirestore.instance.collection('ATTENDANCE').doc(Onlydate).collection(widget.text2).where('status',isEqualTo: 'Absent').snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Text("0",style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.bold),)
                        : Text(snapshot.data!.docs.length.toString(),style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.bold),
                    );
                  }
              ),
            ],),

            SizedBox(height: 10.0,),
            Row(children: [
              Text("Students Present: ",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(137, 2, 43, 18),),),
              StreamBuilder<QuerySnapshot>(
                //stream: FirebaseFirestore.instance.collection('ATTENDANCE').doc(Onlydate).collection('BEETHEM').snapshots(),
                  stream: FirebaseFirestore.instance.collection('ATTENDANCE').doc(Onlydate).collection('PREMPEH').where('status',isEqualTo: 'Present').snapshots(),
                  builder: (context, snapshot) {

                    if(snapshot.hasData) {
                      c = int.tryParse(snapshot.data!.docs.length.toString());
                      e=e!+c!;
                    }
                    else{
                      c=0;
                      e=e!+c!;
                    }

                    return !snapshot.hasData
                        ? Text("0",style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.bold),)
                        : Text(snapshot.data!.docs.length.toString(),style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.bold),
                    );
                  }
              ),
            ],),


            SizedBox(height: 20.0,),
            Center(child:
            Text(" BANKS HOUSE ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.0,color: Colors.white,backgroundColor: Color.fromARGB(255, 5, 56, 16)),
            ),
            ),
            SizedBox(height: 10.0,),
            Row(children: [
              Text("Total Students: ",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(137, 2, 43, 18),),),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('BANKS').snapshots(),
                  //  stream: FirebaseFirestore.instance.collection('ATTENDANCE').doc(Onlydate).collection(widget.text2).where('status',isEqualTo: 'Absent').snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Text("0",style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.bold),)
                        : Text(snapshot.data!.docs.length.toString(),style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.bold),
                    );
                  }
              ),
            ],),

            SizedBox(height: 10.0,),
            Row(children: [
              Text("Students Present: ",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(137, 2, 43, 18),),),
              StreamBuilder<QuerySnapshot>(
                //stream: FirebaseFirestore.instance.collection('ATTENDANCE').doc(Onlydate).collection('BEETHEM').snapshots(),
                  stream: FirebaseFirestore.instance.collection('ATTENDANCE').doc(Onlydate).collection('BANKS').where('status',isEqualTo: 'Present').snapshots(),
                  builder: (context, snapshot) {

                    if(snapshot.hasData) {
                      d = int.tryParse(snapshot.data!.docs.length.toString());
                      e=e!+d!;
                    }
                    else{
                      d=0;
                      e=e!+d!;
                    }
                e!=a!+b!+c!+d!;

                    return !snapshot.hasData
                        ? Text("0",style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.bold),)
                        : Text(snapshot.data!.docs.length.toString(),style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.bold),
                    );
                  }
              ),
            ],),


            
            SizedBox(height: 30.0,),
            Divider(height: 5.0,color: Color.fromARGB(137, 2, 43, 18),thickness: 5.0,),
            SizedBox(height: 5.0,),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child:
            Row(children: [
              
             Text("Total Stds Present: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.black87),
            ),
              
              Text(e.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.green),
              ),
            ],),),
            SizedBox(height: 5.0,),
            Divider(height: 5.0,color: Color.fromARGB(137, 2, 43, 18),thickness: 5.0,),

            SizedBox(height: 20.0),


          ],
        ),
      ),
    );
  }


}