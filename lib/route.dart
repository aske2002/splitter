
import 'package:flutter/material.dart';

import 'package:splitter/Screens/Verify/verify_screen.dart';
import 'package:splitter/Screens/Welcome/welcome_screen.dart';
import 'package:splitter/Screens/Home/home_screen.dart';

import 'package:splitter/Models/VerifyScreenArguments.dart';

const String welcomePage = 'welcome';
const String verificationPage = 'verify';
const String homePage = 'home';

void login() {}

// controller function with switch statement to control page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case welcomePage:
      return MaterialPageRoute(builder: (context) => WelcomeScreen());
    case verificationPage:
      final arguments = settings.arguments as VerifyArguments;
      return MaterialPageRoute(builder: (context) => VerifyScreen(email: arguments.email, password: arguments.password,phone: arguments.phone,));
    case homePage:
      return MaterialPageRoute(builder: (context) => HomeScreen());
    default:
      throw ('this route name does not exist');
  }
}
