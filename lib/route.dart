import 'package:flutter/material.dart';

import 'package:splitter/Models/VerifyScreenArguments.dart';
import 'package:splitter/Models/Imagearguments.dart';
import 'package:splitter/Models/ListModel.dart';

import 'package:splitter/Screens/Verify/verify_screen.dart';
import 'package:splitter/Screens/Welcome/welcome_screen.dart';
import 'package:splitter/Screens/Home/home_screen.dart';
import 'package:splitter/Screens/Picture/picture_screen.dart';
import 'package:splitter/Screens/EditList/editlist_screen.dart';
import 'package:splitter/Screens/AddPeople/addpeople_screen.dart';
import 'package:splitter/Screens/SelectPayers/selectpayers_screen.dart';
import 'package:splitter/Screens/List/list_screen.dart';
import 'package:splitter/Screens/EditList/list_widget.dart';

const String welcomePage = 'welcome';
const String verificationPage = 'verify';
const String homePage = 'home';
const String picturePage = 'picture';
const String editListPage = 'editList';
const String addPeoplePage = 'addPeople';
const String selectPayersPage = 'selectPayers';
const String listPage = 'list';
const String editList2 = "editList2";

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
    case picturePage:
      return MaterialPageRoute(builder: (context) => PictureScreen());
    case editListPage:
      final arguments = settings.arguments as ImageArguments;
      return MaterialPageRoute(builder: (context) => EditListScreen(base64image: arguments.image,));
    case addPeoplePage:
      final arguments = settings.arguments as SplitterList;
      return MaterialPageRoute(builder: (context) => AddPeopleWidget(list: arguments,));
    case selectPayersPage:
      final arguments = settings.arguments as SplitterList;
      return MaterialPageRoute(builder: (context) => SelectPayersWidget(list: arguments));
    case listPage:
      final arguments = settings.arguments as SplitterList;
      return MaterialPageRoute(builder: (context) => ListWidget(list: arguments));
    case editList2:
      return MaterialPageRoute(builder: (context) => EditAbleListWidget());
    default:
      throw ('this route name does not exist');
  }
}
