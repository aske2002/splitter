import 'package:flutter/material.dart';
import 'dart:typed_data';


import 'package:splitter/constants.dart';
import 'package:splitter/route.dart' as route;

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void apiTest() async {
    String base64 = "as";
    List<int> intList = base64.codeUnits;
    Uint8List uint8 = Uint8List.fromList(intList);
    try {
      RestOptions options = RestOptions(
        path: '/parseimg',
        body: uint8
      );
      RestOperation restOperation = Amplify.API.post(
        restOptions: options
      );
      RestResponse response = await restOperation.response;
      print(response);
      print(new String.fromCharCodes(response.data));
    } on ApiException catch (e) {
      print('POST call failed: $e');
    }
  }
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kSecondaryBackground,
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 70,
            color: Colors.white,
          ),
          Center(
            heightFactor: 0.2,
             child: FloatingActionButton(
              onPressed: () {Navigator.pushNamed(context, route.picturePage);},
              backgroundColor: kPrimaryColor,
              child: Icon(Icons.add_rounded, size: 35,),
              elevation: 0.1,
            ),
          ),
          Container(
            width: size.width,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.home_rounded, size: 35, color: kPrimaryColor,)
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.list_rounded, size: 35, color: kPrimaryGreyColor,)
                ),
                Container(
                  width: size.width*0.1,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications_rounded, size: 35, color: kPrimaryGreyColor,)
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.settings_rounded, size: 35, color: kPrimaryGreyColor,)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}