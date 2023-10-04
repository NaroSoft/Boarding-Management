
import 'package:bh_ms/HomeScreens/home_page.dart';
import 'package:bh_ms/Student_Info/detailpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Student_Info/add_student.dart';
import '../Authentication/authentication_page.dart';
import 'attendance_home.dart';


class StudentList extends StatefulWidget {
  final String text,text2;
  const StudentList({Key? key,required this.text, required this.text2}) : super(key: key);
  static const routeName = '/homePage';
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  late String id;
  late String usernames;
  late String useremails;

  String _stdCourseController='Present';

  int _value = 1;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  navigateToDetail(DocumentSnapshot post){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(post: post, text2: widget.text2, text: widget.text)));
  }
  
  String finalDate='';

  getCurrentDate(){

    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    setState(() {

      finalDate = formattedDate.toString() ;

    });

  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentDate();
  }
  final _firestore = FirebaseFirestore.instance;

  List<DataCell> _createCellsForElement(DocumentSnapshot document){
    return <DataCell>[
      DataCell(Text(document.data()!['student_name'].toString())),
      DataCell(Text(document.data()!['student_course'].toString())),
      DataCell(Text(document.data()!['status'].toString())),
    ];
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
                        image:  AssetImage('assets/newback.png'))),
                child: Stack(children: <Widget>[

                  Positioned(
                      bottom: 40.0,
                      left: 16.0,
                      child: Text(widget.text,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500))),
                  Positioned(
                      bottom: 12.0,
                      left: 16.0,
                      child: Text('${widget.text2} House',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500))),
                ])),

            SizedBox(height: 20,),
            ListTile(
              leading: Icon(
                Icons.home_outlined,
                size: 40,
                color: Colors.black45,
              ),
              title: Text(
                "Home Page",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage(text: widget.text2,text2: widget.text)));
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
                size: 40,
                color: Colors.black45,
              ),
              title: Text(
                "Add New Student",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AddStudent(house: widget.text2,text: widget.text)));
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
                size: 40,
                color: Colors.black45,
              ),
              title: Text(
                "Student Attendance",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentList(text: widget.text2,text2: widget.text)));
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
                size: 40,
                color: Colors.black45,
              ),
              title: Text(
                "LogOut",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
        backgroundColor: Colors.black38,
        leading:  IconButton(
    icon: Icon(Icons.arrow_back), onPressed: () { 

     },
    ),
        title: Text('${widget.text} House List',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.group_add_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Attendance_Home(text: widget.text2,text2: widget.text)));
            },
          )
        ],

       // backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0,),
                  Center(child: Text('Student Attendance on ${finalDate}', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),),
                  SizedBox(height: 10.0,),
                  StreamBuilder<QuerySnapshot>(
                    stream:  _firestore.collection('ATTENDANCE').doc(finalDate).collection(widget.text2).snapshots(),
                    builder: (context, snapshot){
                      List<DataRow> rankLines = <DataRow>[];
                      if(snapshot.hasData){
                        final ranks = snapshot.data?.docs;
                        for(var rankData in ranks!){

                          rankLines.add(
                              DataRow(
                                  cells: _createCellsForElement(rankData)
                              )
                          );
                        }
                      }
                      return Container(
                        child: SingleChildScrollView(
                         // scrollDirection: Axis.horizontal,

                          child: DataTable(
                            sortAscending: true,
                            sortColumnIndex: 0,

                            columns: <DataColumn>[
                              DataColumn(label: Text('Name')),
                              DataColumn(label:Text('Course')),
                              DataColumn(label:Text('Status')),
                            ],
                            rows: rankLines,
                          ),
                        ),
                      );
                    },
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}

