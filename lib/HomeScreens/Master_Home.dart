import 'package:bh_ms/Authentication/authentication_page.dart';
import 'package:bh_ms/Ezzat/head_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

//void main() => runApp(HomeScreen());

class Head_Home extends StatefulWidget {
  final String text,text2;
  const Head_Home({Key? key,required this.text, required this.text2}) : super(key: key);
  @override
  _Head_Home createState() => _Head_Home();
}

class _Head_Home extends State<Head_Home>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  TextEditingController _stdNunberController=TextEditingController();

  String title = "Home";



  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 4, vsync: this);
    countDocuments();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

    var totalbee=0;
    var totalfol=0;
    var totalban=0;
    var totalpre=0;
    var totalnumber=0;
    var totalez=0;

   void countDocuments() async{
    QuerySnapshot _myDoc=await FirebaseFirestore.instance.collection("BEETHEM").get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    totalbee=_myDocCount.length;

    QuerySnapshot _myDoc1=await FirebaseFirestore.instance.collection("FOLSON").get();
    List<DocumentSnapshot> _myDocCount1 = _myDoc1.docs;
    totalfol=_myDocCount1.length;

    QuerySnapshot _myDoc2=await FirebaseFirestore.instance.collection("BANKS").get();
    List<DocumentSnapshot> _myDocCount2 = _myDoc2.docs;
    totalban=_myDocCount2.length;

    QuerySnapshot _myDoc3=await FirebaseFirestore.instance.collection("PREMPEH").get();
    List<DocumentSnapshot> _myDocCount3 = _myDoc3.docs;
    totalpre=_myDocCount3.length;

    QuerySnapshot _myDoc4=await FirebaseFirestore.instance.collection("Ezzart").get();
    List<DocumentSnapshot> _myDocCount4 = _myDoc4.docs;
    totalez=_myDocCount4.length;

    setState(() {
      totalnumber= totalfol+totalban+totalbee+totalpre;
    });
   }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 14, 7, 51),
            title: Text(title,style: TextStyle(color: Colors.white),),
            centerTitle: true,
            leading: Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 35, 126, 40),
              ),
          ),
          body: TabBarView(
            children: <Widget>[
              //FirstTabs("Page Two"),

              ListView(children: [
      SizedBox(height: 20.0,),
      Center(
        child: Text("Welcome",style: TextStyle(fontSize: 22.0,color: Color.fromARGB(255, 16, 3, 37),fontWeight: FontWeight.bold),),
      ),
      SizedBox(height: 20.0,),
      Center(
        child: SizedBox(
          height: 200.0,
          width: MediaQuery.of(context).size.width,
          child: Carousel(
            images: [
              ExactAssetImage("assets/image2.png"),
              ExactAssetImage("assets/image5.png"),
              ExactAssetImage("assets/newback1.png"),
              ExactAssetImage("assets/splash1.png"),
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

                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                  height: 170,
                  width: MediaQuery.of(context).size.width*0.5,
                  child: Column(
                    children: [
                      Text("Total Number of Students",style: TextStyle(
                        fontWeight: FontWeight.bold,color: Color.fromARGB(255, 77, 43, 31),
                        fontSize: 17,
                        ),),
                        Text(totalnumber.toString(),style: TextStyle(
                        fontWeight: FontWeight.bold,color: Colors.grey,
                        fontSize: 24,
                        ),),

                        Divider(color: Colors.black,),

                        Text("Students on Exeat",style: TextStyle(
                        fontWeight: FontWeight.bold,color: Color.fromARGB(255, 226, 99, 53),
                        fontSize: 17,
                        ),),
                        
                        Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "  Number:  ",style: TextStyle(
                                      fontWeight: FontWeight.bold,color: Colors.brown,
                                      fontSize: 18,
                                      ),
                                  ),
                                  TextSpan(
                                    text: totalez.toString(),style: TextStyle(
                                      fontWeight: FontWeight.bold,color: Color.fromARGB(255, 155, 150, 148),
                                      fontSize: 20,
                                      ),
                                  )
                                ]
                              ),
                            ),
                          ],
                        ),

                       
                       Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              primary: Color.fromARGB(255, 6, 68, 21),
              
              ),

              onPressed: (){
                 Navigator.push(context, MaterialPageRoute(
                   builder: (context)=> HeadView(
                    text: widget.text2,text2: widget.text
                   ) 
                    ));
              },
              child: Text("Check Details"),
              ),
              ),


                    ],
                  ),
                  ),
              ),
             

      Center(
        child: Text("Number of Students in Halls",style: TextStyle(fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.bold),),
      ),
      SizedBox(height: 20.0,),

      Row(children: [
        SizedBox(width: 10.0,),
        Text("BEETHEM HOUSE: ",style: TextStyle(fontSize: 18.0),),

        Text(totalbee.toString(),style: TextStyle(fontSize: 30.0,color: Colors.black,fontWeight: FontWeight.bold),),
      
      ],),

      SizedBox(height: 10.0,),
      Row(children: [
        SizedBox(width: 10.0,),
        Text("FOLSON HOUSE: ",style: TextStyle(fontSize: 18.0),),
        Text(totalfol.toString(),style: TextStyle(fontSize: 30.0,color: Colors.deepPurple,fontWeight: FontWeight.bold),)
      ],),

      SizedBox(height: 10.0,),
      Row(children: [
        SizedBox(width: 10.0,),
        Text("BANKS HOUSE: ",style: TextStyle(fontSize: 18.0),),
        Text(totalban.toString(),style: TextStyle(fontSize: 30.0,color: Color.fromARGB(255, 10, 99, 57),fontWeight: FontWeight.bold),)
        
      ],),

      SizedBox(height: 10.0,),
      Row(children: [
        SizedBox(width: 10.0,),
        Text("PREMPEH HOUSE: ",style: TextStyle(fontSize: 18.0),),
        Text(totalpre.toString(),style: TextStyle(fontSize: 30.0,color: Color.fromARGB(255, 80, 41, 4),fontWeight: FontWeight.bold),)
       
      ],),

    ]
    ),

              SecondTabs(),
              ThirdTabs(),
              FourthTabs("Page Three")
            ],
// if you want yo disable swiping in tab the use below code
//            physics: NeverScrollableScrollPhysics(),
            controller: tabController,
          ),
          bottomNavigationBar: Material(
            color: Colors.white,
            child: TabBar(
              onTap: (indedx) {
                if (indedx == 0) {
                  setState(() {
                    title = "Home";
                  });
                } else if (indedx == 1) {
                  setState(() {
                    title = "Student Info";
                  });
                } else if (indedx == 2) {
                  setState(() {
                    title = "Student Attendance";
                  });
                }
                   else if (indedx == 3) {
                  setState(() {
                    title = "Log-Out";
                  });
                }
              },
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.grey,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.home_outlined),
                  text: "Home",
                ),
                Tab(
                  icon: Icon(Icons.contact_mail_sharp),
                  text: "Student Info",
                ),
                Tab(
                  icon: Icon(Icons.list_alt),
                  text: "Attendance",
                ),
                Tab(
                  icon: Icon(Icons.logout),
                  text: "LogOut",
                ),
              ],
              controller: tabController,
            ),
          ),
        );
  }
}

class SecondTabs extends StatefulWidget {
  @override
  SecondTabsState createState() => SecondTabsState();
}

class SecondTabsState extends State<SecondTabs>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  String finalDate='';
  late String Onlydate;

  getCurrentDate(){
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    //print(formatted); // something like 2013-04-20

    setState(() {

      finalDate = formatted.toString() ;

    });

  }

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 4, vsync: this);
    getCurrentDate();
  }

  final _firestore = FirebaseFirestore.instance;

  List<DataCell> _createCellsForElement(DocumentSnapshot document){
    return <DataCell>[
      DataCell(Text(document.data()!['student_name'].toString())),
      DataCell(Text(document.data()!['student_course'].toString())),
    //  DataCell(Text(document.data()['status'].toString())),
    ];
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            height: 50.0,
            child: new TabBar(
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: "BEETHEM",
                ),
                Tab(
                  text: "BANKS",
                ),
                Tab(
                  text: "FOLSON",
                ),
                Tab(
                  text: "PREMPEH",
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0,),
                        Center(child: Text('Student Info', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),),
                        SizedBox(height: 10.0,),
                        StreamBuilder<QuerySnapshot>(
                          stream:  _firestore.collection('BEETHEM').snapshots(),
                          builder: (context, snapshot){
                            List<DataRow> rankLines = <DataRow>[];
                            if(snapshot.hasData){
                              final ranks = snapshot.data!.docs;
                              for(var rankData in ranks){

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
                                   // DataColumn(label:Text('Status')),
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


            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0,),
                        Center(child: Text('Student Info', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),),
                        SizedBox(height: 10.0,),
                        StreamBuilder<QuerySnapshot>(
                          stream:  _firestore.collection('BANKS').snapshots(),
                          builder: (context, snapshot){
                            List<DataRow> rankLines = <DataRow>[];
                            if(snapshot.hasData){
                              final ranks = snapshot.data!.docs;
                              for(var rankData in ranks){

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
                                   // DataColumn(label:Text('Status')),
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


            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0,),
                        Center(child: Text('Student Info', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),),
                        SizedBox(height: 10.0,),
                        StreamBuilder<QuerySnapshot>(
                          stream:  _firestore.collection('FOLSON').snapshots(),
                          builder: (context, snapshot){
                            List<DataRow> rankLines = <DataRow>[];
                            if(snapshot.hasData){
                              final ranks = snapshot.data!.docs;
                              for(var rankData in ranks){

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
                                    //DataColumn(label:Text('Status')),
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


            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0,),
                        Center(child: Text('Student Info', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),),
                        SizedBox(height: 10.0,),
                        StreamBuilder<QuerySnapshot>(
                          stream:  _firestore.collection('PREMPEH').snapshots(),
                          builder: (context, snapshot){
                            List<DataRow> rankLines = <DataRow>[];
                            if(snapshot.hasData){
                              final ranks = snapshot.data!.docs;
                              for(var rankData in ranks){

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
                                   // DataColumn(label:Text('Status')),
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



          ],
        ),
      ),
    );
  }
}






class ThirdTabs extends StatefulWidget {
  @override
  ThirdTabsState createState() => ThirdTabsState();
}


class ThirdTabsState extends State<ThirdTabs>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  String Onlydate='2021-01-01';

  String finalDate='';

  DateTime selectedDate = DateTime.now();
  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());

  getCurrentDate(){
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    //print(formatted); // something like 2013-04-20

    setState(() {

      finalDate = formatted.toString() ;

    });

  }

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 4, vsync: this);
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
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            height: 50.0,
            child: new TabBar(
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: "BEETHEM",
                ),
                Tab(
                  text: "BANKS",
                ),
                Tab(
                  text: "FOLSON",
                ),
                Tab(
                  text: "PREMPEH",
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
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

                ThirdTabs();
              },
          child: IconButton(
              icon: Icon(Icons.calendar_today,color: Colors.white,),
              iconSize: 35.0,
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

                ThirdTabs();
              },),
        ),
        body: TabBarView(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0,),
                        Center(child: Text('Student Attendance for ${Onlydate}', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.black45),),),
                        SizedBox(height: 10.0,),
                        StreamBuilder<QuerySnapshot>(
                          stream:  _firestore.collection('ATTENDANCE').doc(Onlydate).collection('BEETHEM').snapshots(),
                          builder: (context, snapshot){
                            List<DataRow> rankLines = <DataRow>[];
                            if(snapshot.hasData){
                              final ranks = snapshot.data!.docs;
                              for(var rankData in ranks){

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


            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0,),
                        Center(child: Text('Student Attendance for ${Onlydate}', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.black45),),),
                        SizedBox(height: 10.0,),
                        StreamBuilder<QuerySnapshot>(
                          stream:  _firestore.collection('ATTENDANCE').doc(Onlydate).collection('BANKS').snapshots(),
                          builder: (context, snapshot){
                            List<DataRow> rankLines = <DataRow>[];
                            if(snapshot.hasData){
                              final ranks = snapshot.data!.docs;
                              for(var rankData in ranks){

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


            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0,),
                        Center(child: Text('Student Attendance for ${Onlydate}', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.black45),),),
                        SizedBox(height: 10.0,),
                        StreamBuilder<QuerySnapshot>(
                          stream:  _firestore.collection('ATTENDANCE').doc(Onlydate).collection('FOLSON').snapshots(),
                          builder: (context, snapshot){
                            List<DataRow> rankLines = <DataRow>[];
                            if(snapshot.hasData){
                              final ranks = snapshot.data!.docs;
                              for(var rankData in ranks){

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


            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0,),
                        Center(child: Text('Student Attendance for ${Onlydate}', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.black45),),),
                        SizedBox(height: 10.0,),
                        StreamBuilder<QuerySnapshot>(
                          stream:  _firestore.collection('ATTENDANCE').doc(Onlydate).collection('PREMPEH').snapshots(),
                          builder: (context, snapshot){
                            List<DataRow> rankLines = <DataRow>[];
                            if(snapshot.hasData){
                              final ranks = snapshot.data!.docs;
                              for(var rankData in ranks){

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



          ],
        ),
      ),
    );
  }
}


class FirstTabs extends StatelessWidget {
  final String title;

  FirstTabs(this.title);

  

  final mySnackBar = SnackBar(
    content: Text(
      "Hello There!",
      style: TextStyle(color: Colors.white),
    ),
    duration: Duration(seconds: 3),
    backgroundColor: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    /*return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
              child: Text(title + "  Click me"),
              onPressed: () => {Scaffold.of(context).showSnackBar(mySnackBar)}),
        ],
      ),
    );*/
    return ListView(children: [
      SizedBox(height: 20.0,),
      Center(
        child: Text("Welcome",style: TextStyle(fontSize: 22.0,color: Color.fromARGB(255, 3, 54, 31),fontWeight: FontWeight.bold),),
      ),
      SizedBox(height: 20.0,),
      Center(
        child: SizedBox(
          height: 200.0,
          width: MediaQuery.of(context).size.width,
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

                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width*0.5,
                  child: Column(
                    children: [
                      Text("Total Number of Students",style: TextStyle(
                        fontWeight: FontWeight.bold,color: Color.fromARGB(255, 77, 43, 31),
                        fontSize: 17,
                        ),),
                        Text("1260",style: TextStyle(
                        fontWeight: FontWeight.bold,color: Colors.grey,
                        fontSize: 16,
                        ),),

                        Divider(color: Colors.black,),

                        Text("Students on Exeat",style: TextStyle(
                        fontWeight: FontWeight.bold,color: Color.fromARGB(255, 226, 99, 53),
                        fontSize: 17,
                        ),),
                        
                        Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "  Number:  ",style: TextStyle(
                                      fontWeight: FontWeight.bold,color: Colors.brown,
                                      fontSize: 18,
                                      ),
                                  ),
                                  TextSpan(
                                    text: "30",style: TextStyle(
                                      fontWeight: FontWeight.bold,color: Color.fromARGB(255, 155, 150, 148),
                                      fontSize: 20,
                                      ),
                                  )
                                ]
                              ),
                            ),
                          ],
                        ),

                       
                       Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              primary: Color.fromARGB(255, 6, 68, 21),
              
              ),

              onPressed: (){
                 // Navigator.push(context, MaterialPageRoute(
                   // builder: (context)=> HomePage() 
                    //));
              },
              child: Text("Check Details"),
              ),
              ),


                    ],
                  ),
                  ),
              ),
             

      Center(
        child: Text("Number of Students in Halls",style: TextStyle(fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.bold),),
      ),
      SizedBox(height: 20.0,),

      Row(children: [
        SizedBox(width: 10.0,),
        Text("BEETHEM HOUSE: ",style: TextStyle(fontSize: 18.0),),
      StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('BEETHEM').snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(
                child: Text("0"))
                : Center(
                child: Text(snapshot.data!.docs.length.toString(),style: TextStyle(fontSize: 30.0,color: Colors.black,fontWeight: FontWeight.bold),)
            );
          }
      ),
      ],),

      SizedBox(height: 10.0,),
      Row(children: [
        SizedBox(width: 10.0,),
        Text("FOLSON HOUSE: ",style: TextStyle(fontSize: 18.0),),
        Text("",style: TextStyle(fontSize: 30.0,color: Colors.deepPurple,fontWeight: FontWeight.bold),)
      ],),

      SizedBox(height: 10.0,),
      Row(children: [
        SizedBox(width: 10.0,),
        Text("BANKS HOUSE: ",style: TextStyle(fontSize: 18.0),),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('BANKS').snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(
                  child: Text("0"))
                  : Center(
                  child: Text(snapshot.data!.docs.length.toString(),style: TextStyle(fontSize: 30.0,color: Color.fromARGB(255, 10, 99, 57),fontWeight: FontWeight.bold),)
              );
            }
        ),
      ],),

      SizedBox(height: 10.0,),
      Row(children: [
        SizedBox(width: 10.0,),
        Text("PREMPEH HOUSE: ",style: TextStyle(fontSize: 18.0),),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('PREMPEH').snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(
                  child: Text("0"))
                  : Center(
                  child: Text(snapshot.data!.docs.length.toString(),style: TextStyle(fontSize: 30.0,color: Color.fromARGB(255, 80, 41, 4),fontWeight: FontWeight.bold),)
              );
            }
        ),
      ],),

    ]
    );
  }
}


class FourthTabs extends StatelessWidget {
  final String title;

  FourthTabs(this.title);

  final mySnackBar = SnackBar(
    content: Text(
      "Hello There!",
      style: TextStyle(color: Colors.white),
    ),
    duration: Duration(seconds: 3),
    backgroundColor: Colors.blue,
  );

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    /*return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
              child: Text(title + "  Click me"),
              onPressed: () => {Scaffold.of(context).showSnackBar(mySnackBar)}),
        ],
      ),
    );*/
    return Column(
      children: [
        SizedBox(height: 250.0,),
        Center(child: Text("Tap to Sign-Out",style: TextStyle(fontSize: 25.0,color: Color.fromARGB(255, 12, 112, 15)),),),
        SizedBox(height: 10.0,),
        Center(
          child: FloatingActionButton(
            //materialTapTargetSize: MaterialTapTargetSize.padded,
            backgroundColor: Color.fromARGB(255, 8, 61, 15),

            child: Icon(Icons.exit_to_app_outlined,size: 40.0,color: Colors.white,),
            onPressed: (){
              _firebaseAuth.signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AuthenticationPage()), (route) => false);
            },
          ),
        ),
      ],
    );
  }
}