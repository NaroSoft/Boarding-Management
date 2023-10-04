import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Authentication/authentication_page.dart';
import '../Ezzat/home_page.dart';
import '../attendance/attendance_home.dart';
import '../Authentication/authentication_page.dart';
import 'home_page.dart';


class House_Login_Home extends StatefulWidget {
  final String text,text2;
  const House_Login_Home({Key? key,required this.text, required this.text2}) : super(key: key);
  @override
  _House_Login_HomeState createState() => _House_Login_HomeState();
}

class _House_Login_HomeState extends State<House_Login_Home>{
  int ttnumb=0;

  final Future<int> documents = FirebaseFirestore.instance.collection('products').snapshots().length;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
 /*   StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('BEETHEM').snapshots(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            DocumentSnapshot data = snapshot.data.documents[index];
            ttnumb=snapshot.data.docs.length;
            return null;
          },
        );
      },

    );*/
   

  



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //countDocuments();
   // getCount();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference mycon = FirebaseFirestore.instance.collection('BEETHEM');
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
                      bottom: 30.0,
                      left: 10.0,
                      child: Text(widget.text,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              backgroundColor: Colors.black,
                              fontWeight: FontWeight.w500))),
                  Positioned(
                      bottom: 8.0,
                      left: 10.0,
                      child: Text('${widget.text2} House',
                          style: TextStyle(
                              color: Color.fromARGB(255, 203, 195, 235),
                              backgroundColor: Colors.black,
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
        //backgroundColor: Colors.black38,
        backgroundColor: Color.fromARGB(255, 34, 3, 73),
        title: Text("Home Screen",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body:
          SingleChildScrollView(child:
      Column(children: [
        SizedBox(height: 20.0,),
        Center(
          child: Text("Welcome ${widget.text}",style: TextStyle(fontSize: 22.0,color: Color.fromARGB(255, 11, 3, 46),fontWeight: FontWeight.bold),),
        ),
      SizedBox(height: 20.0,),
      Center(
        child: SizedBox(
          height: 400.0,
          width: 300.0,
          child: Carousel(
            images: [
              ExactAssetImage("assets/image5.png"),
              ExactAssetImage("assets/image2.png"),
              ExactAssetImage("assets/image3.png"),
              ExactAssetImage("assets/image4.png"),
              ExactAssetImage("assets/newback1.png"),
            ],
            autoplay: true,
            animationDuration: Duration(milliseconds: 800),
            dotSize: 10.0,
            dotSpacing: 20.0,
            dotColor: Colors.green,
            borderRadius: true,
          ),
        ),
      ),
        SizedBox(height: 30.0,),
        Center(
          child: Text("Total Number of Students",style: TextStyle(fontSize: 15.0,color: Colors.black54,fontWeight: FontWeight.bold),),
        ),
        SizedBox(height: 20.0,),

    StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection(widget.text2).snapshots(),
    builder: (context, snapshot) {
      return !snapshot.hasData
          ? Center(
          child: Text("0",style: TextStyle(fontSize: 50.0,color: Colors.black,fontWeight: FontWeight.bold),))
          : Center(
          child: Text(snapshot.data!.docs.length.toString(),style: TextStyle(fontSize: 50.0,color: Colors.black,fontWeight: FontWeight.bold),)
      );
    }
    ),
      
      ],),
              )
    );
  }
}
