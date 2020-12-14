
import 'home.page.dart';
import 'login.page.dart';
import 'auth.service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


AuthService appAuth = new AuthService();
/*void initState() async {
  bool _isLoggedIn;
  SharedPreferences prefs = await SharedPreferences.getInstance();
       _isLoggedIn  =  (prefs.getBool('log') ?? 0);
    main();
}*/
/*isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      int _isLoggedIn  =  (prefs.getInt('log') ?? 0);
      return _isLoggedIn;
}*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("1");
 // SharedPreferences prefs = await SharedPreferences.getInstance();
  //bool _isLoggedIn  =  (prefs.getBool('log') ?? 0);
  // Set default home.
  Widget _defaultHome = new LoginPage();
  print("2");
  // Get result of the login function.
  //bool _isLoggedIn =  appAuth.isLoggedIn();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool _isLoggedIn  =  (prefs.getBool('log') ?? false);
  print("This is");
  print(_isLoggedIn);
  if(_isLoggedIn) {
    print("3");
    _defaultHome = new HomePage();
  }
  print("4");
  // Run app!
  runApp(new MaterialApp(
    title: 'App',
    home: _defaultHome,
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new HomePage(),
      '/login': (BuildContext context) => new LoginPage()
    },
  ));
}
