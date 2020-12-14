import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.page.dart';

import 'liquid_progress_indicator.dart';
import 'main.dart';
var title;
var rollno, password, purl, name, attendance, atd, type, period_attendance_status, attendance_color;
var present_color=Colors.green[900], absent_color = Colors.red[900];
var period_number = new List();
var period = new List();
var present = new List();
var topic = new List();
var period_attendance_color = new List();
//period_number.add(s);
int percentage;
class HomePage extends StatefulWidget{
  //var title;
  @override
  State<StatefulWidget> createState() => new _HomePageState();
  //String title;
}
class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

AnimationController _animationController;
//Future<String> test() => title = Future.delayed(Duration(seconds: 2), () => "Done");
  @override
  Widget build(context) {
    //if(attendance != null){
      return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
        //backgroundColor: Colors.teal[100],
          appBar: AppBar(
            backgroundColor: Colors.orange[800],
            bottom: TabBar(
              indicatorColor: Colors.blueGrey[800],
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.insert_invitation)),
                //Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('Vardhaman Student App',
            style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                       )),
            actions: <Widget>[ new FlatButton(
                      child: new Text(
                        'Logout'
                      ),
                      onPressed: () {
                        appAuth.logout().then(
                              Navigator.of(context).pushReplacementNamed('/login')
                      );
                    }
            )],
          ),
          body: 
          // new Padding(
          //padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 10.0),
           //child:
                  TabBarView(
                  children: [
                     new Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 10.0),
                        child: new Column(
                        children: <Widget>[
                        //new Text('Welcome to App!'),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                          new Row( 
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ConditionalBuilder(
                                condition: attendance != null,
                                builder: (context) {  
                                return(SizedBox(
                                    width: 76.0,
                                    height: 76.0,
                                    child: LiquidCircularProgressIndicator(
                                    value: (percentage+0.0)/100, // Defaults to 0.5.
                                    valueColor: AlwaysStoppedAnimation(attendance_color),
                                    //valueColor: AlwaysStoppedAnimation(attendance_color), // Defaults to the current Theme's accentColor.
                                    backgroundColor: Colors.white, // Defaults to the current Theme's backgroundColor.
                                    borderColor: Colors.blueGrey,
                                    borderWidth: 2.5,
                                    direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                    center: Text(attendance+"%",
                                    style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                         ),
                                        ),
                                      ),
                                    )
                                  );
                                }
                              ),  
                              ConditionalBuilder(
                                condition: attendance == null,
                                builder: (context) {  
                                return( SizedBox(
                                    width: 75.0,
                                    height: 75.0,
                                    child: LiquidCircularProgressIndicator(
                                    value: 0.0, // Defaults to 0.5.
                                    valueColor: AlwaysStoppedAnimation(Colors.pink), // Defaults to the current Theme's accentColor.
                                    backgroundColor: Colors.white, // Defaults to the current Theme's backgroundColor.
                                    borderColor: Colors.red,
                                    borderWidth: 1.5,
                                    direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                    center: Text("loading..."),
                                      ),
                                    )
                                  );
                                }
                               ),
                              ]
                            ),
                           new Row( 
                             mainAxisAlignment: MainAxisAlignment.end,
                             crossAxisAlignment: CrossAxisAlignment.end,
                             children: <Widget>[
                             //children: <Widget>[  
                              new Image.network(
                               purl,
                               height: 110.0,
                               width: 110.0,
                              ),
                            ]),
                        ]
                      ),
                      new Text("\n"),   
                        new Row( 
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text("Name : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            new Text(name,
                            style: GoogleFonts.varelaRound()
                            ),
                            Text("\n"),
                          ],
                        //child: new Text("Hey..."),
                          
                        ),
                        ConditionalBuilder(
                          condition: attendance != null,
                          builder: (context) {  
                          return(new Container(
                            child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text("Attendance : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              new Text(attendance+"%",
                              //style: GoogleFonts.varelaRound()
                              ),
                            ])
                            ));
                          } //builder
                        ),  
                        ConditionalBuilder(
                          condition: attendance == null,
                          builder: (context) {  
                          return( new Container( child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text("Attendance : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              new Text("loading...",
                                style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.orange[500],
                                  ),
                                  //style: GoogleFonts.varelaRound()
                                ),
                              ]),
                            ));
                          }
                         ),
                  ],
                )),
              new SingleChildScrollView(
                child:new Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
                  child: new Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  ConditionalBuilder(
                    condition: period_attendance_status == "True",
                    builder: (context) {  
                    return(
                          new Column(
                          children: <Widget>[
                            Table(
                                  border: TableBorder.all(color: Colors.black),
                                  children: [
                                    TableRow(children: [
                                      Text('Period',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                      Text('Course',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                      Text('Topics Covered',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                      ),
                                    ),
                                      Text('Status',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      ),
                                    ),
                                    ]),
                                    
                                    for(var i=0;i<period_number.length;i++)                                    
                                    TableRow(children: [                                
                                      Text(period_number[i].toString(),textAlign: TextAlign.center),
                                      Text(period[i].toString(),textAlign: TextAlign.center),
                                      Text(topic[i].toString(),textAlign: TextAlign.center),
                                      Text(present[i].toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: period_attendance_color[i],
                                      ),
                                      ),
                                      /*ConditionalBuilder(
                                      condition: present[i] == "PRESENT",
                                      builder: (context) {  
                                      return(
                                      Text(present[i].toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[900],
                                      ),
                                      ));},
                                      fallback: (context) {
                                        return Text('This gets rendered');
                                      },*/
                                      

                                      //Text('Cell 5'),
                                      //Text('Cell 6'),
                                      //Text('Cell 7'),
                                      ],
                                    ),
                                    /*TableRow(children: [
                                      Text('Cell 1'),
                                      Text('Cell 2'),
                                      Text('Cell 3'),
                                      Text('Cell 4'),
                                      //Text('Cell 5'),
                                      //Text('Cell 6'),
                                      //Text('Cell 7'),
                                      ],
                                    ),*/
                                    
                              ]
                            ),
                          ],)
                        );
                    
                    },),
                    ConditionalBuilder(
                        condition: period_attendance_status == null && period_number.isEmpty,
                        builder: (context) {  
                        return(new Container( 
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                         // new Column(
                              children: <Widget>[
                              Text("\n"),
                              new CircularProgressIndicator(),
                               Text("\n\nloading...",
                               style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[200],
                                ),
                              ), 
                              ])
                        ));
                        },),
                    ConditionalBuilder(
                        condition: period_attendance_status == "None",
                        builder: (context) {  
                        return(new Container( 
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                         // new Column(
                              children: <Widget>[
                              //new CircularProgressIndicator(),
                               Text("\nHey, no one posted attendance today.... \n🤔\n\n",
                              textAlign: TextAlign.center,
                               style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.5,
                                  color: Colors.red[700],
                                ),
                              ),
                              Text("Is today Sunday or a Holiday 😎",
                              textAlign: TextAlign.center,
                               style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.green[900],
                                ),
                              ),
                              /*Text("🤑", 
                              style:TextStyle(fontFamily: 'NotoEmoji')
                              ) */
                              ])
                        ));
                        },),
                    ],),),
                    //Icon(Icons.directions_bike),
              ),],
                  ),
                //),
              ),
             ), 
    );
  /*  }
   else {
     return new Scaffold(
        appBar: new AppBar(
          title: new Text('Home'),
        ),
        body: new Container(
          margin: new EdgeInsets.only(
            top: 50.0
          ),
          alignment: Alignment.center,
          child:  
          new Column(
              children:  <Widget>[
                    new CircularProgressIndicator(),
              ],
          ),
        ),
      ); 
    }*/
  } 
  
get_data() async {
//String temp = pas;
//print(temp);
//pas = temp.substring(1);
print("ting.....ting");
print(rollno + password+"hey............................");
ver = rollno.substring(0) +"_" + password.substring(1);
var uri = 'https://vardhamanapp.herokuapp.com/attendance/'+ver.substring(0);
var data = await http.get(uri);
var jsondata = json.decode(data.body);
print(rollno + password+"hey............................");
//print(jsondata["text"]);
await setState(() {
      type = jsondata["type"];
      attendance = jsondata["attendance"].toString();
      if(type == "int"){
        percentage = int.parse(attendance);
        if(percentage < 60){
           attendance_color = Colors.deepOrangeAccent[700];;
        }
        if(percentage >= 60 && percentage <= 75){
           attendance_color = Colors.deepOrangeAccent[400];
        }
        if(percentage >= 75.0 && percentage < 80.0){
           attendance_color = Colors.orange[500];
        }
        if(percentage >= 80 && percentage < 90){
           attendance_color = Colors.green[400];
        }
        if(percentage >= 90 && percentage < 100){
           attendance_color = Colors.green[600];
        }
        if(percentage == 100){
           attendance_color = Colors.green[900];
        }  
      }
      if(type == "float"){
      percentage = (double.parse(attendance)).floor();
      if(percentage < 60.0){
           attendance_color = Colors.deepOrangeAccent[700];
        }
      if(percentage >= 60.0 && percentage <= 75.0){
         attendance_color = Colors.deepOrangeAccent[400];
      }
      if(percentage >= 75.0 && percentage < 80.0){
         attendance_color = Colors.orange[500];
      }
      if(percentage >= 80.0 && percentage < 90.0){
         attendance_color = Colors.green[400];
      }
      if(percentage >= 90.0 && percentage < 100.0){
         attendance_color = Colors.green[600];
      }
      if(percentage == 100){
         attendance_color = Colors.green[900];
        }  
      }
        
    });
  print(attendance+type);
  _animationController.addListener(() => setState(() {}));
    _animationController.repeat();        
}

set_data() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    rollno = prefs.getString('rollno');
    name = prefs.getString('name');
    password = prefs.getString('password');
  });
    print("Name here");
    print(password);
    print(name);
    var t = name.split(" ");
    name = "";
    for( int i = 0 ; i< t.length ; i++ ) { 
    var t1 = t[i];
    name = name +t1[0].toUpperCase()+(t1.substring(1)).toLowerCase()+" ";
    print(i);
    print(name);
    //t1 = t[i+1];
    //name = name + " " ;//+ (t[i+1][0].toUpperCase()+(t1.substring(1)).toLowerCase());
    //print(name);
    //print("Hey"+name);
     }
    if(rollno[7] == '5'){
    purl = "http://resources.vardhaman.org/images/" + "cse/" + rollno + ".jpg";
    }
    if(rollno[7] == '4'){
    purl = "http://resources.vardhaman.org/images/" + "ece/" + rollno + ".jpg";
    }
    if(rollno[7] == '3'){
    purl = "http://resources.vardhaman.org/images/" + "mech/" + rollno + ".jpg";
    }
    if(rollno[6] == '0' && rollno[7] == '2'){
    purl = "http://resources.vardhaman.org/images/" + "eee/" + rollno + ".jpg";
    }
    if(rollno[7] == '1'){
    purl = "http://resources.vardhaman.org/images/" + "civil/" + rollno + ".jpg";
    }
    if(rollno[6] == '1' && rollno[7] == '2'){
    purl = "http://resources.vardhaman.org/images/" + "it/" + rollno + ".jpg";
    }
//purl = "http://resources.vardhaman.org/images/" + "cse/" + "18881A0526" + ".jpg";
get_data();
get_period_attendance();
}
get_period_attendance() async {
  ver = rollno.substring(0) +"_" + password.substring(1);
  var period_uri = 'https://vardhamanapp.herokuapp.com/period_attendance/'+ver.substring(0);
  var data = await http.get(period_uri);
  var jsondata = json.decode(data.body);
     for( int i = 1 ; i<=7 ; i++ ) { 
      try{
        print("In get perriod attendance");
        var temp = jsondata[i.toString()];
        print(temp);
        if(temp != null){
          period_number.add(i.toString());
        }
        temp = temp.split("_-_");
        setState(() {
          print("Colors man");
          print(period_attendance_color);
          present.add(temp[0].toString());
          period.add(temp[1].toString());
          topic.add(temp[2].toString());
          if(temp[0].toString() == "PRESENT"){
           period_attendance_color.add(present_color); 
          }
          if(temp[0].toString() == "ABSENT"){
            period_attendance_color.add(absent_color);
          }
          
        });
        print("Colors man1");
          print(period_attendance_color);
        //print(period_number);
       // print(period);
        //print(topic);
     }
     catch(e){
      print("In catch block, come to me...");
      print("Colors man22");
          print(period_attendance_color);
    }
    }
    period_attendance_status = jsondata["status"].toString();
print("Colors man2");
          print(period_attendance_color);
        print(period_number);
  }
@override
void initState() {
  super.initState();
  print("This is it");
  
   set_data();
   print("goin to ");
   //get_period_attendance();
  //print('$title');
 _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5)      
    );
 // get_data();
  }

@override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

}