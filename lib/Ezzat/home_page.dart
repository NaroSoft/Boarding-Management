import 'package:bh_ms/Ezzat/add_ezzart.dart';
import 'package:bh_ms/HomeScreens/House_Login_Home.dart';
import 'package:bh_ms/Student_Info/detailpage.dart';
import 'package:bh_ms/attendance/attendance_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../HomeScreens/home_page.dart';
import '../Student_Info/add_student.dart';
import '../Authentication/authentication_page.dart';



class EzzartHomePage extends StatefulWidget {
  final String text,text2;
  const EzzartHomePage({Key? key,required this.text, required this.text2}) : super(key: key);
  static const routeName = '/homePage';
  @override
  _EzzartHomePageState createState() => _EzzartHomePageState();
}

class _EzzartHomePageState extends State<EzzartHomePage> {
  String id="";
  String usernames="";
  String useremails="";

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
                              fontWeight: FontWeight.w500))),
                  Positioned(
                      bottom: 12.0,
                      left: 16.0,
                      child: Text('${widget.text2} House',
                          style: TextStyle(
                              color: Color.fromARGB(255, 1, 20, 4),
                              fontSize: 20.0,
                              
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
        backgroundColor: Color.fromARGB(255, 13, 3, 59),
        title: Text('${widget.text2}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person_add,
              color: Colors.white,
              size: 40.0,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddEzzatStudent(house: widget.text2,text: widget.text)));
            },
          )
        ],
       // backgroundColor: Colors.black,
      ),
      body:
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Ezzart').where('status', isEqualTo: 'Not In').snapshots(),
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
                    navigateToDetail(snapshot.data!.docs[index]);
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
                                padding: const EdgeInsets.only(left: 5,right: 5,top: 3),
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

                                                  //SizedBox(width: 5),
                                                  Text(snapshot.data!.docs[index].data()["student_name"], style: TextStyle(color: Color.fromARGB(255, 2, 27, 3),fontWeight: FontWeight.w500, fontSize: 18.0,fontFamily: 'Roboto-Black'),)
                                                ],
                                              ),

                                             SizedBox(height:3.0),

                                              Text(snapshot.data!.docs[index].data()["student_course"],style: TextStyle(fontWeight: FontWeight.w700,fontSize:18.0,color: Color.fromARGB(181, 39, 119, 15)),),
                                              
                                             SizedBox(height:3.0),

                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "From : ",
                                                      style: TextStyle(color: Colors.black54),
                                                    ),

                                                    TextSpan(
                                                      text: snapshot.data!.docs[index].data()["from"],
                                                      style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),
                                                    )
                                                  ]
                                                )
                                              ),

                                              SizedBox(height:3.0),

                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "To : ",
                                                      style: TextStyle(color: Colors.black54),
                                                    ),

                                                    TextSpan(
                                                      text: snapshot.data!.docs[index].data()["to"],
                                                      style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),
                                                    )
                                                  ]
                                                )
                                              ),

                                               Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "House : ",
                                                      style: TextStyle(color: Colors.black54),
                                                    ),

                                                    TextSpan(
                                                      text: snapshot.data!.docs[index].data()["house"],
                                                      style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),
                                                    )
                                                  ]
                                                )
                                              ),


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


}