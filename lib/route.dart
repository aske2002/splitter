
import 'package:flutter/material.dart';

import 'package:splitter/Screens/Verify/verify_screen.dart';
import 'package:splitter/Screens/Welcome/welcome_screen.dart';

const String welcomePage = 'welcome';
const String verificationPage = 'verify';

void login() {}

// controller function with switch statement to control page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case welcomePage:
      return MaterialPageRoute(builder: (context) => WelcomeScreen());
    case verificationPage:
      return MaterialPageRoute(builder: (context) => VerifyScreen());
    default:
      throw ('this route name does not exist');
  }
}
