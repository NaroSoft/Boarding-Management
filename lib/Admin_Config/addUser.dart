import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddUsers extends StatefulWidget {
  @override
  _AddUsersState createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userPhoneController = TextEditingController();
  TextEditingController _nameController= TextEditingController();
  String _statusController ="House Master";
  String _houseController="BANKS";
  String _btnTitle = 'Create Account';
  bool _isSignIn = true;
  String _authTitle = 'Sign In';
  bool _isLoading = false;
  int _value = 1;
  int _values = 1;

  Future _performAuthentication(BuildContext context, String email, String password) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    String email = _emailController.text.toString();
    String password = _passwordController.text.toString();

      setState(() {
        _isLoading = true;
      });
      await  _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        if(value != null) {

          Map<String, dynamic> UserData = new Map<String,dynamic>();

          setState(() {
            _isLoading = true;
          });
          UserData["user_name"] = _nameController.text;
          UserData["user_email"] = _emailController.text;
          UserData["user_house"] = _houseController;
          UserData["user_phone"] = _userPhoneController.text;
          UserData["user_status"] = _statusController;

          FirebaseFirestore.instance
              .collection("user").doc(_emailController.text)
              .set(UserData)
              .whenComplete((){
            setState(() {
              _isLoading = false;
            });
            Navigator.pop(context);
          } );

        /*  setState(() {
            _isLoading = false;
          });
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);*/
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      });

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
      appBar: AppBar(
        leading:
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromARGB(255, 35, 126, 40),
        centerTitle: true,
        title: Text('New User Info',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        /* actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.filter_b_and_w,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],*/

        // backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/splash.png"),
                        /*color: Color.fromARGB(255, 2, 51, 23),
                size: 100.0,*/
                      ),
                      SizedBox(height: 10.0),
                      Center(child: Text('Boarding House\nManagement System', style: TextStyle(color: Colors.black, fontSize: 25.0), textAlign: TextAlign.center)),
                    ],
                  ),
                  SizedBox(height: 80.0),
                  Container(
                    height: 50.0,
                    child: TextFormField(
                      style: TextStyle(color: Color.fromARGB(255, 2, 51, 23),fontSize: 18.0),
                      controller: _nameController,
                      cursorColor: Color.fromARGB(255, 2, 51, 23),
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        labelText: 'Type Name',
                        labelStyle: TextStyle(color: Color.fromARGB(255, 2, 95, 43), fontSize: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 50.0,
                    child: TextFormField(
                      style: TextStyle(color: Color.fromARGB(255, 2, 51, 23),fontSize: 18.0),
                      controller: _emailController,
                      cursorColor: Color.fromARGB(255, 2, 51, 23),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        labelText: 'Type Email',
                        labelStyle: TextStyle(color: Color.fromARGB(255, 2, 95, 43), fontSize: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 50.0,
                    child: TextFormField(
                      style: TextStyle(color: Color.fromARGB(255, 2, 51, 23),fontSize: 18.0),
                      controller: _passwordController,
                      cursorColor: Color.fromARGB(255, 2, 51, 23),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        labelText: 'Type Password',
                        labelStyle: TextStyle(color: Color.fromARGB(255, 2, 95, 43), fontSize: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Row(children: [
                    Text("Select House: ",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(255, 1, 7, 3)),),
                    SizedBox(width: 10.0,),
                    DropdownButton(

                        value: _value,
                        items: [
                          DropdownMenuItem(
                            child: Text("BANKS",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(255, 3, 59, 36)),),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("BEETHEM",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(255, 3, 51, 25)),),
                            value: 2,
                          ),
                          DropdownMenuItem(
                              child: Text("PREMPEH",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(255, 4, 54, 16)),),
                              value: 3
                          ),
                          DropdownMenuItem(
                              child: Text("FOLSON",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(255, 5, 48, 30)),),
                              value: 4,
                          ),
                          DropdownMenuItem(
                              child: Text("ALL",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(255, 5, 49, 14)),),
                              value: 5
                          )
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value = value as int;
                            if(value==1){
                              _houseController="BANKS";
                            }
                            else if(value==2){
                              _houseController="BEETHEM";
                            }
                            else if(value==3){
                              _houseController="PREMPEH";
                            }
                            else if(value==4){
                              _houseController="FOLSON";
                            }
                            else if(value==5){
                              _houseController="ALL";
                            }
                          });
                        }),

                  ],),
                  SizedBox(height: 20.0),
                  Container(
                    child: TextFormField(
                      style: TextStyle(color: Color.fromARGB(255, 2, 51, 23),fontSize: 20.0,fontWeight: FontWeight.bold,),
                      controller: _userPhoneController,
                      cursorColor: Color.fromARGB(255, 2, 51, 23),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 2, 51, 23),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 2, 51, 23),
                          ),
                        ),
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Color.fromARGB(255, 2, 95, 43), fontSize: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(children: [
                    Text("Select Status: ",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(255, 1, 17, 8)),),
                    SizedBox(width: 10.0,),
                    DropdownButton(

                        value: _values,
                        items: [
                          DropdownMenuItem(
                            child: Text("House Master",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(255, 5, 66, 46)),),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("Principal",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(255, 4, 85, 31)),),
                            value: 2,
                          ),
                          DropdownMenuItem(
                              child: Text("Vice Principal",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(255, 3, 70, 42)),),
                              value: 3
                          ),
                          DropdownMenuItem(
                              child: Text("Matron",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(255, 4, 63, 31)),),
                              value: 4
                          )
                        ],
                        onChanged: (value) {
                          setState(() {
                            _values = value as int;
                            if(value==1){
                              _statusController="House Master";
                            }
                            else if(value==2){
                              _statusController="Principal";
                            }
                            else if(value==3){
                              _statusController="Vice Principal";
                            }
                            else{
                              _statusController="Matron";
                            }
                          });
                        }),

                  ],),
                  SizedBox(height: 20.0),
                  Container(
                    height: 50.0,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if(_emailController.text.isEmpty && _passwordController.text.isEmpty) {
                          _mostrarAlert('Error', 'Provide username or password');
                        } else {
                          if(_nameController.text.isEmpty){
                            _mostrarAlert('Error', 'Provide User Fullname');
                          }
                          else{
                            if(_emailController.text.isEmpty){
                              _mostrarAlert('Error', 'Provide User Email');
                            }
                            else{
                              if(_passwordController.text.isEmpty){
                                _mostrarAlert('Error', 'Provide User Password');
                              }
                              else{
                                if(_userPhoneController.text.isEmpty)
                                _mostrarAlert('Error', 'Provide User Password');
                                else{
                                  _performAuthentication(context, _emailController.text, _passwordController.text);
                                }
                              }
                            }
                          }
                        }
                      },
                      color: Color.fromARGB(255, 4, 82, 33),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      child: Text(_btnTitle, style: GoogleFonts.roboto(color: Colors.white, fontSize: 20.0)),
                    ),
                  ),
                  SizedBox(height: 20.0),
               /*   FlatButton(
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AuthenticationPage()), (route) => false);
                      },
                      child: Text("Sign In", style: GoogleFonts.roboto(color: Colors.black, fontSize: 20.0))
                  )*/
                ],
              ),
            ),
            SizedBox(height: 20.0),
            _isLoading ? Container(
              margin: EdgeInsets.symmetric(horizontal: 50.0),
              child: Center(
                child: LinearProgressIndicator(minHeight: 5.0,color: Color.fromARGB(255, 3, 65, 5),backgroundColor: Color.fromARGB(255, 78, 10, 5),),
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
}
