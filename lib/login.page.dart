//import 'package:vmyapp/main.dart';
import 'auth.service.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:progress_dialog/progress_dialog.dart';

//import 'package:flash/flash.dart';

double progressValue = 0;
//Stopwatch watch = new Stopwatch();
AnimationController animationController;
Animation<Color> animation;
TextEditingController TRollNo =  TextEditingController();
TextEditingController TPassword =  TextEditingController();
var RollNo, Password, Valid = "" , ver, Name, site_status;

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final _formKey = GlobalKey<FormState>();
  final _progress = new GlobalKey<ScaffoldState>();
  //final focus = FocusNode();
  FocusNode focus;

  login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('rollno', (RollNo));
    prefs.setString('password', (TPassword.text).toString());
    print("hey..............");
    prefs.setString('name', Name);
    print(Name+"In login");
    if(Valid == "true"){
    prefs.setBool('log', true); 
    }
    else if(Valid == "false"){
      prefs.setBool('log', false); 
    }
  }
  check() async {
var uri = 'https://vardhamanapp.herokuapp.com/check/'+ver.toString();
print(uri);
//print("Hey......11111111");
var data = await http.get(uri);
//print("Hey.....22222222222");
var jsondata = json.decode(data.body);

//print("Hey......");
//print(jsondata);
print(jsondata["text"]);
//print("Ok");
await setState(() {
      print("In sheck......."+Password);
      print(jsondata["valid"]);
      if(jsondata["valid"] == 'True'){
        RollNo = jsondata["rollno"];
        Password = jsondata["pas"];
        Name = jsondata["name"];
        Valid = "true";
      }
      else if(jsondata["valid"] == 'False'){
        Valid = "false";
      }
      try{
        site_status = jsondata['site'];
        print(site_status);
        print("hahaha");
      }
      catch(e){
        site_status = "";
      }
      
    });

}

  @override
  Widget build(BuildContext context) => new Scaffold(
         // key: _snack,
          key: _progress,
    appBar: new AppBar(
      backgroundColor: Colors.orange[800],
      title: new Text('Login'),
    ),
body:  Form(
      key: _formKey,
      child: Column(
        
  ///new margin: const EdgeInsets.only(left: 20.0, right: 20.0),
  ///  new Padding(padding: new EdgeInsets.all(20.0)),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 10.0, 70.0, 10.0),
          child: 
             TextFormField(
          /* onChanged: (val) {
          setState(() {
            age = ;
          });
          },*/
            controller: TRollNo,
            textAlign: TextAlign.center,
            textInputAction: TextInputAction.next,
            autofocus: true,
            onFieldSubmitted: (v){
             FocusScope.of(context).requestFocus(focus);
              },
            decoration: InputDecoration(
 ///   contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 100.0, 10.0),
            labelText: "Roll No",
            labelStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.green),
              
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          ),
         
          Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 10.0, 70.0, 10.0),
          child: 
              TextFormField(
            controller: TPassword,
            focusNode: focus,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.green)
            ),
             obscureText: true,
            validator: (value) {
              if (value.isEmpty) {
              return 'Please enter some text';
              }
              return null;
            },
          ),
          ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              color: const Color.fromRGBO(247, 64, 106, 1.0),
              onPressed: () async {

            /*_linear.currentState.showSnackBar(new SnackBar(
              content: new Text("Validating Credentials!!",
                          textAlign: TextAlign.center,
              style: new TextStyle(
                              color: Colors.white,                                
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                  ),
                ),
              ));*/
              /*child: new Column(children: <Widget>[
            //new Expanded(
              LinearProgressIndicator(
              key: _progress,
              backgroundColor: Colors.red,
              value: 5.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
            );
            //);
    //]);*/
             // LinearProgressIndicator(key:_progress);
                if (_formKey.currentState.validate()) {
            //child:
               _progress.currentState.showSnackBar(new SnackBar(
                    //key: _progress,
                    duration: new Duration(seconds: 5) ,
                    behavior: SnackBarBehavior.fixed,
                    content:
                      new Row( 
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[ 
                          new CircularProgressIndicator(),
                        ]),
                      //backgroundColor: Colors.transparent,
                     ));
                      setState(() {
                        String temp = (TPassword.text).toString();
                        print(temp);
                        Password = temp.substring(1);
                        RollNo = (TRollNo.text).toString();
                        ver = RollNo.substring(0) +"_" + Password.substring(0);
                        print(ver);
                      });
                        
                      await check();
                      if (Valid == "true") {
                        print("Entered if block");
                        login();
                        Navigator.of(context).pushReplacementNamed('/home');
                      }
                      else if(Valid == "false"){
                        print("Else.... block");

                        _progress.currentState.showSnackBar(new SnackBar(
                          content: new Text("Wrong Password",
                          style: new TextStyle(
                                //backgroundColor: Colors.red,
                                color: Colors.redAccent,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ));
                        
                      }
                      else if(site_status == "down"){
                        _progress.currentState.showSnackBar(new SnackBar(
                          content: new Text("Students Corner site may not be WORKING.....",
                          style: new TextStyle(
                                //backgroundColor: Colors.red,
                                color: Colors.redAccent[700],
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ));
                      }
                     
                      /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()));*/
                }
                
                //Navigator.pushNamed(context, "/home");
                
                //home: HomePage ();
              },
              child: new Text(
              "Log In",
               style: new TextStyle(
               color: Colors.white,
               fontSize: 20.0,
               fontWeight: FontWeight.w300,
               letterSpacing: 0.3,
              ),
             ),
            ),
          ),
        ],
      ),
    ),
  
  );

    @override
  void initState() {
  super.initState();
  AuthService appAuth = new AuthService();

     focus = FocusNode();
  }

 @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focus.dispose();

    super.dispose();
  }
}