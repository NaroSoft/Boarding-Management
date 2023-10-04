import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'attendance_detail.dart';

class Date_List extends StatefulWidget {
  final String text,text2,post,myid;
  const Date_List({Key? key,required this.text, required this.text2,required this.post, required this.myid}) : super(key: key);
  static const routeName = '/homePage';
  @override
  _Date_ListState createState() => _Date_ListState();
}

class _Date_ListState extends State<Date_List> {
  late String id;
  late String usernames;
  late String useremails;
  late var _value;
  late String _stdCourseController;

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
   Navigator.push(context, MaterialPageRoute(builder: (context) => Attendance_Detail(post: post,text: widget.text,text2: widget.text2,myid: widget.myid)));
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black38,
        title: Text('${widget.text2} House List',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      /*actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.filter_b_and_w,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>Student_Attendance(text: widget.text,text2: widget.text2,)));
            },
          )
        ],*/
       // backgroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('ATTENDANCE').doc(widget.post).collection(widget.text2).snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: double.infinity,
                  child: Row(

                    children: <Widget>[
                      Flexible(child: ListTile(
                        onTap: (){
                          navigateToDetail(snapshot.data!.docs[index]);
                        },
                        title:  SizedBox(
                          height: MediaQuery.of(context).size.height*0.17,
                          width: MediaQuery.of(context).size.width,
                          child:  Card(
                            elevation: 0,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 5,right: 5,top: 5),
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

                                                    SizedBox(width: 5),
                                                    Text('ID:  ', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0,fontFamily: 'Roboto-Black',color: Colors.black45)),
                                                    Text(snapshot.data!.docs[index].id, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,fontFamily: 'Roboto-Black')),

                                                  ],
                                                ),

                                                SizedBox(height:7.0),

                                                Row(
                                                  children: <Widget>[

                                                    SizedBox(width: 5),
                                                    Text('Name:  ', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0,fontFamily: 'Roboto-Black',color: Colors.black45)),
                                                    Text(snapshot.data!.docs[index].data()['student_name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,fontFamily: 'Roboto-Black'),),
                                                  ],
                                                ),

                                                 SizedBox(height:7.0),

                                                Row(
                                                  children: <Widget>[

                                                    SizedBox(width: 5),
                                                    Text('Course:  ', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0,fontFamily: 'Roboto-Black',color: Colors.black45)),
                                                   Text(snapshot.data!.docs[index].data()['student_course'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,fontFamily: 'Roboto-Black'),),

                                                  ],
                                                ),
                                                  SizedBox(height: 7.0,),

                                                Row(
                                                  children: <Widget>[

                                                    SizedBox(width: 5),
                                                    Text('Status:  ', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0,fontFamily: 'Roboto-Black',color: Colors.black45)),
                                                    Text(snapshot.data!.docs[index].data()['status'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,fontFamily: 'Roboto-Black'),),

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
        },

      ),

                );
  }


}