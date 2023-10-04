import 'package:bh_ms/Ezzat/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../HomeScreens/House_Login_Home.dart';
import '../Authentication/authentication_page.dart';
import '../HomeScreens/home_page.dart';
import 'attendance_detail.dart';
import 'date_list.dart';
import 'student_attendance.dart';

class Attendance_Home extends StatefulWidget {
  final String text,text2;
  const Attendance_Home({Key? key,required this.text, required this.text2}) : super(key: key);
  static const routeName = '/homePage';
  @override
  _Attendance_HomeState createState() => _Attendance_HomeState();
}

class _Attendance_HomeState extends State<Attendance_Home> {
  late String id;
  late String usernames;
  late String useremails;
  var _value;
  late String _stdCourseController;
  bool _isLoading=false;
  String Onlydate=DateFormat("yyyy-MM-dd").format(DateTime.now());
  DateTime selectedDate = DateTime.now();
  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());

 Future getPosts() async {
    //DocumentSn apshot variable = await Firestore.instance.collection('user').document(widget.text).get();
   await FirebaseFirestore.instance.collection("user").doc(useremails).snapshots().listen((event) {
            setState(() {
              usernames = event.get("user_name");

            });
  });
        }


  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  navigateToDetail(DocumentSnapshot post){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Attendance_Detail(post: post,text: widget.text,text2: widget.text2,myid: Onlydate)));
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  final dateController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image:  AssetImage('assets/newback1.png'))),
                child: Stack(children: <Widget>[

                  Positioned(
                      bottom: 40.0,
                      left: 16.0,
                      child: Text(widget.text,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              backgroundColor: Colors.black,
                              fontWeight: FontWeight.w500))),
                  Positioned(
                      bottom: 12.0,
                      left: 16.0,
                      child: Text('${widget.text2} House',
                          style: TextStyle(
                              color: Color.fromARGB(255, 230, 229, 250),
                              fontSize: 20.0,
                              backgroundColor: Colors.black,
                              fontWeight: FontWeight.w500))),
                ])),

            SizedBox(height: 20,),
            ListTile(
              leading: Icon(
                Icons.home_outlined,
                size: 30,
                color: Color.fromARGB(255, 5, 59, 23),
              ),
              title: Text(
                "Home Page",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context)=> House_Login_Home(text: widget.text2,text2: widget.text)));
                Route route= MaterialPageRoute(builder: (context)=>House_Login_Home(text: widget.text2,text2: widget.text));
                Navigator.pushReplacement(context, route);
              },
            ),
            Divider(
              height: 10,
              color: Colors.black,
              indent: 65,
            ),
            ListTile(
              leading: Icon(
                Icons.person_add_alt_1_outlined,
                size: 30,
                color: Color.fromARGB(255, 5, 59, 23),
              ),
              title: Text(
                "Student Info",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage(text2: widget.text2,text: widget.text)));
                //Navigator.of(context).pushReplacementNamed('/AddBlogPage');
                Route route= MaterialPageRoute(builder: (context)=>HomePage(text2: widget.text2,text: widget.text));
                Navigator.pushReplacement(context, route);
              },
            ),
            Divider(
              height: 20,
              indent: 65,
              color: Colors.black,
            ),
            ListTile(
              leading: Icon(
                Icons.article_outlined,
                size: 30,
                color: Color.fromARGB(255, 5, 59, 23),
              ),
              title: Text(
                "Student Attendance",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentList(text: widget.text2,text2: widget.text)));
                //Navigator.push(context, MaterialPageRoute(builder: (context)=> Attendance_Home(text: widget.text,text2: widget.text2,)));
                //Route route= MaterialPageRoute(builder: (context)=>Attendance_Home(text: widget.text,text2: widget.text2,));
                Route route= MaterialPageRoute(builder: (context)=>Attendance_Home(text2: widget.text2,text: widget.text));
                Navigator.pushReplacement(context, route);
                //Navigator.of(context).pushReplacementNamed('/AddBlogPage');
              },
            ),
            Divider(
              height: 20,
              indent: 65,
              color: Colors.black,
            ),
            ListTile(
              leading: Icon(
                Icons.article_outlined,
                size: 30,
                color: Color.fromARGB(255, 5, 59, 23),
              ),
              title: Text(
                "Student Exeat",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentList(text: widget.text2,text2: widget.text)));
                //Navigator.push(context, MaterialPageRoute(builder: (context)=> Attendance_Home(text: widget.text,text2: widget.text2,)));
                //Route route= MaterialPageRoute(builder: (context)=>Attendance_Home(text: widget.text,text2: widget.text2,));
                Route route= MaterialPageRoute(builder: (context)=>EzzartHomePage(text2: widget.text2,text: widget.text));
                Navigator.pushReplacement(context, route);
                //Navigator.of(context).pushReplacementNamed('/AddBlogPage');
              },
            ),
            Divider(
              height: 20,
              indent: 65,
              color: Colors.black,
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                size: 30,
                color: Color.fromARGB(255, 5, 59, 23),
              ),
              title: Text(
                "LogOut",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                _firebaseAuth.signOut();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AuthenticationPage()), (route) => false);
              },
            ),

          ],
        ),
      ),
      
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 24, 2, 43),
        centerTitle: true,
        title: Text('${widget.text2} House List',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.post_add,
              color: Colors.white,
              size: 35.0,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    //backgroundColor: Colors.grey,
                      content:
                            Form(

                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[

                                  Text("Select Date", style: TextStyle(
                                    color: Color.fromARGB(255, 8, 46, 9),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,),),

                                  SizedBox(height: 20.0,),
                                  TextField(
                                    readOnly: true,
                                    controller: dateController,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold,color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: 'Pick your Date',
                                      labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.0),
                                    ),
                                    onTap: () async {
                                      var date = await showDatePicker(
                                        
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2021),
                                          lastDate: DateTime(2100));
                                      dateController.text = date.toString().substring(0, 10);
                                    },
                                  ),
                                  SizedBox(height: 20.0,),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RaisedButton(
                                      child: Text("Procced",
                                        style: TextStyle(fontSize: 22.0),),
                                      textColor: Colors.white,
                                      color: Color.fromARGB(255, 13, 66, 26),
                                      onPressed: () {
                                        //pname=productNameController.text;
                                        //setup the Alert
                                        AlertDialog alert = AlertDialog(
                                          title: Text(" Comfirmation"),
                                          content: Text(
                                              "Would you like to Generate Attendance List for the Date?"),
                                          actions: [
                                            FlatButton(onPressed: () {
                                              Navigator.of(context).pop();
                                              @override
                                              void dispose() {
                                                //print("Disposing second route");
                                                super.dispose();
                                              }
                                            },
                                              child: Text('Cancel'),
                                              color: Colors.red,
                                              textColor: Colors.white,
                                            ),
                                            FlatButton(onPressed: () {
                                              if (dateController.text.isEmpty){
                                                
                                              }
                                              else {
                                              Map<String,
                                                    dynamic> studentData = new Map<
                                                    String,
                                                    dynamic>();

                                                studentData["date"] =
                                                    dateController.text;

                                                FirebaseFirestore.instance
                                                    .collection('ATTENDANCE')
                                                    .doc(dateController.text)
                                                    .set(studentData)
                                                    .whenComplete(()
                                                    {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Student_Attendance(text: widget.text,text2: widget.text2,mydate: dateController.text,)));
                                                    }
                                                );

                                              }

                                            },
                                              child: Text('Continue'),
                                              color: Color.fromARGB(255, 6, 56, 8),
                                              textColor: Colors.white,
                                            ),
                                          ],
                                        );

                                        //show dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),

                      ));
                },
              );
            },
          ),
            ],
       // backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
      backgroundColor: Color.fromARGB(255, 12, 6, 95),
      onPressed: ()async {
          var date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2021),
              lastDate: DateTime(2100));
          setState(() {
            selectedDate = date!;
            Onlydate = new DateFormat("yyyy-MM-dd").format(date);
            //String Onlymonth = new DateFormat("MMMM, yyyy").format(date);
            //String Onlyday = new DateFormat("EEEE - dd").format(date);

            /*        dateController.text = '$Onlymonth';
                                dateController1.text = '$Onlyday';
*/
            //print('$Onlymonth');
            //print('$Onlyday');
          });

        },
      child: IconButton(
        icon: Icon(Icons.calendar_today,color: Colors.white,),
        iconSize: 27.0,
        onPressed: ()async {
          var date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2021),
              lastDate: DateTime(2100));
              if(date!=null){
          setState(() {
            selectedDate = date;
            Onlydate = new DateFormat("yyyy-MM-dd").format(date);
            //String Onlymonth = new DateFormat("MMMM, yyyy").format(date);
            //String Onlyday = new DateFormat("EEEE - dd").format(date);

            /*        dateController.text = '$Onlymonth';
                                dateController1.text = '$Onlyday';
*/
            //print('$Onlymonth');
            //print('$Onlyday');
          });
              }
        },),
    ),
      body:
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
            Expanded(child:
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('ATTENDANCE').doc(Onlydate).collection(widget.text2).snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(child: Text('Tap on the Calender button below',
            style: TextStyle(fontSize: 22.0),),)
              : ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  width: double.infinity,
                  child: Row(

                    children: <Widget>[
                      Flexible(child: ListTile(
                        onTap: () {
                          navigateToDetail(snapshot.data!.docs[index]);
                        },
                        title: SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.17,
                          /*width: MediaQuery
                              .of(context)
                              .size
                              .width,*/
                          child: Card(
                            //color: Colors.black26,
                            elevation: 0,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5, top: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[

                                                    SizedBox(width: 5),
                                                    Text('ID:  ',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            fontSize: 18.0,
                                                            fontFamily: 'Roboto-Black',
                                                            color: Colors
                                                                .black45)),
                                                    Text(snapshot.data!
                                                        .docs[index].id,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            fontSize: 18.0,
                                                            fontFamily: 'Roboto-Black')),

                                                  ],
                                                ),

                                                SizedBox(height: 7.0),

                                                Row(
                                                  children: <Widget>[

                                                    SizedBox(width: 5),
                                                    Text('Name:  ',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            fontSize: 18.0,
                                                            fontFamily: 'Roboto-Black',
                                                            color: Colors
                                                                .black45)),
                                                    Text(snapshot.data!
                                                        .docs[index]
                                                        .data()['student_name'],
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 18.0,
                                                          fontFamily: 'Roboto-Black'),),
                                                  ],
                                                ),

                                                SizedBox(height: 7.0),

                                                Row(
                                                  children: <Widget>[

                                                    SizedBox(width: 5),
                                                    Text('Course:  ',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            fontSize: 18.0,
                                                            fontFamily: 'Roboto-Black',
                                                            color: Colors
                                                                .black45)),
                                                    Text(snapshot.data!
                                                        .docs[index]
                                                        .data()['student_course'],
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 18.0,
                                                          fontFamily: 'Roboto-Black'),),

                                                  ],
                                                ),
                                                SizedBox(height: 7.0,),

                                                Row(
                                                  children: <Widget>[

                                                    SizedBox(width: 5),
                                                    Text('Status:  ',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            fontSize: 18.0,
                                                            fontFamily: 'Roboto-Black',
                                                            color: Colors
                                                                .black45)),
                                                    Text(snapshot.data!
                                                        .docs[index]
                                                        .data()['status'],
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 18.0,
                                                          fontFamily: 'Roboto-Black'),),

                                                  ],
                                                ),

                                                //Text(snapshot.data.docs[index].data()["student_course"],style: TextStyle(fontWeight: FontWeight.w700,fontSize:18.0,color: Colors.black26),),

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
        }),),

           /* Container(
              color: Colors.black26,
              height: 100,
              child:

                Wrap(
                      children: [
                        Text("hjhh"),
                        Text("hjhh"),
                      ],
                    ),
                  ),*/

              SizedBox(height: 10,),

              Padding(
                padding: EdgeInsets.only(left: 10.0, top:10.0),
                child: Column(
                  children: [
                Row(
                children: [
                  Text("Total Students:  ",style: TextStyle(fontSize: 18.0),),

                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection(widget.text2).snapshots(),
                      builder: (context, snapshot) {
                        return !snapshot.hasData
                            ? Center(
                            child: Text("0"))
                            : Center(
                            child: Text(snapshot.data!.docs.length.toString(),style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 7, 7, 7)),)
                        );
                      }
                  ),
                 // Text("1",style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold,color: Colors.deepPurple),),
                ],),
              SizedBox(height: 5,),
              Row(
                children: [
                  Text("Students Present:  ",style: TextStyle(fontSize: 18.0),),
                  StreamBuilder<QuerySnapshot>(
                    stream:FirebaseFirestore.instance.collection('ATTENDANCE').doc(Onlydate).collection(widget.text2).where('status',isEqualTo: 'Present').snapshots(),
                      //stream: FirebaseFirestore.instance.collection(widget.text2).where('status',isEqualTo: 'Present').snapshots(),
                      builder: (context, snapshot) {
                        return !snapshot.hasData
                            ? Center(
                            child: Text("0"))
                            : Center(
                            child: Text(snapshot.data!.docs.length.toString(),style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 19, 122, 23)),)
                        );
                      }
                  ),
                  //Text("1",style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold,color: Colors.green),),
                ],),
              SizedBox(height: 5,),
              Row(
                children: [
                  Text("Students Absent:  ",style: TextStyle(fontSize: 18.0),),
                  //Text("1",style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold,color: Colors.red),),
                  StreamBuilder<QuerySnapshot>(
                      stream:FirebaseFirestore.instance.collection('ATTENDANCE').doc(Onlydate).collection(widget.text2).where('status',isEqualTo: 'Absent').snapshots(),
                      //stream: FirebaseFirestore.instance.collection(widget.text2).where('status',isEqualTo: 'Present').snapshots(),
                      builder: (context, snapshot) {
                        return !snapshot.hasData
                            ? Center(
                            child: Text("0"))
                            : Center(
                            child: Text(snapshot.data!.docs.length.toString(),style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.red),)
                        );
                      }
                  ),
                ],),
                  ],
                ),
                ),
              
              SizedBox(height: 10,),

          ],),


    );
  }

}