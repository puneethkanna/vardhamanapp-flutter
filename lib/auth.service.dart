//import 'dart:async';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
 
  // Login
  isLoggedIn() async {
     
    SharedPreferences prefs = await SharedPreferences.getInstance();
     bool _isLoggedIn  =  (prefs.getBool('log') ?? false);
      print(_isLoggedIn);
      return _isLoggedIn;
  }
  login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('rollno', "abc");
    prefs.setString('password', "abc");
    print("hey..............");
    prefs.setBool('log', true); 
  }

  // Logout
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('rollno');
    prefs.remove('password');
    prefs.remove('name');
    prefs.remove('log'); 
  }
}