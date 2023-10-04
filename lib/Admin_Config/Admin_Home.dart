import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Authentication/authentication_page.dart';
import 'User_List.dart';


class Admin_Home extends StatefulWidget {

  @override
  _Admin_HomeState createState() => _Admin_HomeState();
}

class _Admin_HomeState extends State<Admin_Home>{
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
    Future getCount() async => FirebaseFirestore.instance
        .collection('BEETHEM') //your collectionref
        .where('deleted', isEqualTo: false)
        .get()
        .then((value) {
      var count = 0;
      count = value.docs.length;
      setState(() {
        ttnumb=count;
      });

      return ttnumb;
    });



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
                        image:  AssetImage('assets/newback.png'))),
                child: Stack(children: <Widget>[

                  Positioned(
                      bottom: 40.0,
                      left: 16.0,
                      child: Text('Welcome',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500))),
                  Positioned(
                      bottom: 12.0,
                      left: 16.0,
                      child: Text('ADMINISTRATOR',
                          style: TextStyle(
                              color: Color.fromARGB(255, 5, 59, 23),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500))),
                ])),

            SizedBox(height: 20,),
            ListTile(
              leading: Icon(
                Icons.home_outlined,
                size: 40,
                color: Color.fromARGB(255, 5, 59, 23),
              ),
              title: Text(
                "Home Page",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context)=> House_Login_Home(text: widget.text2,text2: widget.text)));
                Route route= MaterialPageRoute(builder: (context)=>Admin_Home());
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
                size: 40,
                color: Color.fromARGB(255, 5, 59, 23),
              ),
              title: Text(
                "Users Info",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage(text2: widget.text2,text: widget.text)));
                //Navigator.of(context).pushReplacementNamed('/AddBlogPage');
                Route route= MaterialPageRoute(builder: (context)=>User_List());
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
        backgroundColor: Color.fromARGB(255, 35, 126, 40),
        title: Text("Home Screen",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body:
      Column(children: [
        SizedBox(height: 20.0,),
        Center(
          child: Text("Welcome Admin",style: TextStyle(fontSize: 22.0,color: Color.fromARGB(255, 5, 68, 42),fontWeight: FontWeight.bold),),
        ),
      SizedBox(height: 20.0,),
      Center(
        child: SizedBox(
          height: 400.0,
          width: 300.0,
          child: Carousel(
            images: [
              ExactAssetImage("assets/image6.png"),
              ExactAssetImage("assets/image7.png"),
              ExactAssetImage("assets/image8.png"),
              ExactAssetImage("assets/newback.png"),
            ],
            autoplay: true,
            animationDuration: Duration(milliseconds: 1000),
            dotSize: 6.0,
            dotSpacing: 15.0,
            dotColor: Colors.lightGreenAccent,
            borderRadius: true,
          ),
        ),
      ),
        SizedBox(height: 30.0,),
        Center(
          child: Text("Total Number of Users",style: TextStyle(fontSize: 15.0,color: Colors.black54,fontWeight: FontWeight.bold),),
        ),
        SizedBox(height: 20.0,),

    StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('user').snapshots(),
    builder: (context, snapshot) {
      return !snapshot.hasData
          ? Center(
          child: Text("0"))
          : Center(
          child: Text(snapshot.data!.docs.length.toString(),style: TextStyle(fontSize: 50.0,color: Colors.black,fontWeight: FontWeight.bold),)
      );
    }
    ),
      
      ],),
    );
  }
}
