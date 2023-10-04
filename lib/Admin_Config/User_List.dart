// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Authentication/authentication_page.dart';
import 'Admin_Home.dart';
import 'Userdetailpage.dart';
import 'addUser.dart';

// ignore: camel_case_types
class User_List extends StatefulWidget {

  static const routeName = '/homePage';

  const User_List({Key? key}) : super(key: key);

  

  @override
  // ignore: library_private_types_in_public_api
  _User_ListState createState() => _User_ListState();
}

// ignore: camel_case_types
class _User_ListState extends State<User_List> {
  late String id;
  late String usernames;
  late String useremails;
  // ignore: prefer_typing_uninitialized_variables


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
    Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailPage(post: post, text2: '',)));
  }



  @override
  void initState() {
    // ignore: todo
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
                decoration:  BoxDecoration(
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
                              color: Color.fromARGB(255, 2, 46, 24),
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
                size: 30,
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
        title: Text('Users List',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person_add,
              color: Color.fromARGB(255, 229, 226, 226),
              size: 40.0,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddUsers()));
            },
          )
        ],
       // backgroundColor: Colors.black,
      ),
      body:
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: snapshot.data?.docs.length,
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

                              Padding(
                                padding: const EdgeInsets.only(left: 5,right: 5,top: 10),
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

                                                  SizedBox(width: 10),
                                                  Text(snapshot.data!.docs[index].data()["user_name"], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0,fontFamily: 'Roboto-Black'),),

                                             SizedBox(height:10.0),

                                              Text(snapshot.data!.docs[index].data()["user_status"],style: TextStyle(fontWeight: FontWeight.w700,fontSize:18.0,color: Colors.brown),),

                                              SizedBox(height:10.0),

                                              Text(snapshot.data!.docs[index].data()["user_house"],style: TextStyle(fontWeight: FontWeight.w700,fontSize:18.0,color: Color.fromARGB(66, 3, 71, 26)),),

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