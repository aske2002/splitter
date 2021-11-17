import 'package:flutter/material.dart';

import 'package:splitter/constants.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
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
              onPressed: () {},
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
