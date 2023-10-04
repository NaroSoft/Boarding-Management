
import 'package:bh_ms/Admin_Config/Admin_Home.dart';
import 'package:bh_ms/HomeScreens/House_Login_Home.dart';
import 'package:bh_ms/HomeScreens/Master_Home.dart';
import 'package:bh_ms/HomeScreens/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../HomeScreens/Master_Login_Home.dart';
import '../HomeScreens/Matron_Login_Home.dart';
import '../Admin_Config/addUser.dart';


class AuthenticationPage extends StatefulWidget {
  //final String posts;
 // const AuthenticationPage({Key key, this.posts}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

/*
class UserE{
  final String useremail;
  const UserE({this.useremail});

}
*/

class _AuthenticationPageState extends State<AuthenticationPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _btnTitle = 'Sign In';
  bool _isSignIn = true;
  String _authTitle = 'Create Account';
  bool _isLoading = false;
  late DocumentSnapshot documentSnapshot;
  String username="None";
  String userhouse="None";
  late Map<String, dynamic> documentData;

  CollectionReference users = FirebaseFirestore.instance.collection('user');



  Future _performAuthentication(BuildContext context, String email, String password) async {
    try{
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    String email = _emailController.text.toString();
    String password = _passwordController.text.toString();

    setState(() {
        _isLoading = true;
      });
    
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((value) async {
        if(value != null) {

          setState(() {
            _isLoading = false;
          });

          FirebaseFirestore.instance.collection("user").doc(_emailController.text).snapshots().listen((event) {
            setState(() {
              if (event.get("user_status")=="House Master") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          House_Login_Home(text: event.get("user_name"),
                            text2: event.get("user_house"),),
                    ));
              }
              else if(event.get("user_status")=="Principal" || event.get("user_status")=="Vice Principal"){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Head_Home(text: event.get("user_name"),
                            text2: event.get("user_house"),),
                    ));
              }
              else if(event.get("user_status")=="Matron"){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Matron_Login_Home(text: event.get("user_name"),
                            text2: event.get("user_house"),),
                    ));
              }

            });
          });


        } else {
          setState(() {
            _isLoading = false;
          });
          _mostrarAlert("Login Failed", "This haappens as a result of;\n1. No Internet Connection\n2. Incorrect Username\n3. Password");
        }
      });

      } catch(e) {
        setState(() {
            _isLoading = false;
          });
   _mostrarAlert("Login Failed", "This haappens as a result of;\n1. No Internet Connection\n2. Incorrect Username\n3. Password");
          } 
    
  }
  

  _changeButtonTitle() {
    if(_btnTitle == 'Sign In') {
      setState(() {
        _btnTitle = 'Create Account';
        _authTitle = 'Sign In';
        _isSignIn = false;
      });
    } else {
      setState(() {
        _btnTitle = 'Sign In';
        _authTitle = 'Create Account';
        _isSignIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100.0, left: 20.0, right: 20.0),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/image3.png"),
                        /*color: Colors.blueAccent,
                size: 100.0,*/
                      ),
                      SizedBox(height: 10.0),
                      Center(child: Text('Boarding House\nManagement System', style: TextStyle(color: Colors.black, fontSize: 25.0), textAlign: TextAlign.center)),
                    ],
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    height: 50.0,
                    child: TextFormField(
                      style: TextStyle(color: Color.fromARGB(255, 3, 51, 23),fontSize: 18.0),
                      controller: _emailController,
                      cursorColor: Color.fromARGB(255, 5, 2, 24),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 104, 85, 212),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 104, 85, 212),
                          ),
                        ),
                        labelText: 'Type Email',
                        labelStyle: TextStyle(color: Color.fromARGB(255, 10, 65, 33), fontSize: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 50.0,
                    child: TextFormField(
                      style: TextStyle(color: Color.fromARGB(255, 3, 51, 23),fontSize: 18.0),
                      controller: _passwordController,
                      cursorColor: Color.fromARGB(255, 18, 5, 43),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 104, 85, 212),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 104, 85, 212),
                          ),
                        ),
                        labelText: 'Type Password',
                        labelStyle: TextStyle(color: Color.fromARGB(255, 10, 65, 33), fontSize: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 50.0,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if(_emailController.text.isEmpty && _passwordController.text.isEmpty) {
                          _mostrarAlert('Error', 'Provide username or password');
                          //debugPrint('Provide username or password');
                        } else {
                          if(_emailController.text=="admin" && _passwordController.text=="admin"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Home()));
                          }
                          else{
                          
                          _performAuthentication(context, _emailController.text, _passwordController.text);
                        }
                        }
                      },
                      color: Color.fromARGB(255, 17, 4, 48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      child: Text(_btnTitle, style: GoogleFonts.roboto(color: Colors.white, fontSize: 20.0)),
                    ),
                  ),
                  SizedBox(height: 10.0),
               /*   FlatButton(
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AddUsers()), (route) => false);
                      },
                      child: Text("Create Account", style: GoogleFonts.roboto(color: Colors.black, fontSize: 20.0))
                  )*/
                ],
              ),
            ),
            SizedBox(height: 20.0),
            _isLoading ? Container(
            
              margin: EdgeInsets.symmetric(horizontal: 50.0),
              child: Center(
                child: LinearProgressIndicator(
                  minHeight: 5.0,
                color: Color.fromARGB(255, 20, 22, 145),
                backgroundColor: Color.fromARGB(255, 211, 175, 235),
                ),
              ),
            ) : Container(width: 0.0, height: 0.0)
          ],
        ),
      ),
    );
  }

  void _mostrarAlert(String title, String message){
    AlertDialog alertDialog=AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context,builder: (_)=>alertDialog);
  }




  void _sendDataToSecondScreen(BuildContext context) {

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(text: username,text2: userhouse,),
        ));

  }


}
  

  
