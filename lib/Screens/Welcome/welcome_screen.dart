import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:splitter/Screens/Welcome/SignUpModal.dart';

import 'package:splitter/constants.dart';
import 'package:splitter/Screens/Welcome/LoginModal.dart';

// Generated in previous step
import 'package:splitter/amplifyconfiguration.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryAccent,
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset("assets/images/WelcomeBackgroundTop.png", height: size.height*0.4, width: size.width, fit: BoxFit.fill),
            ],
          ),
          SizedBox.expand(
            child: Column(
                children: [
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: size.height*0.2-70, bottom: 10),
                        child: Text("Hey, there", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
                    ),
                    Container(
                        width: size.width*0.8,
                        child: Opacity(
                            opacity: 0.8,
                            child: Text("Welcome to Splitter! Login or Sign up to get started", style: TextStyle(color: Colors.white, fontSize: 22), textAlign: TextAlign.center)
                        )
                    )
                  ],
                )
              ]
            ),
          ),
          SizedBox.expand(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.height*0.6-size.width*0.45),
                  child: Image.asset("assets/images/WelcomeIllustration.png",  width: size.width*0.5, fit: BoxFit.fill),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset("assets/images/WelcomeBackgroundBottom.png", height: size.height*0.4, width: size.width, fit: BoxFit.fill),
            ],
          ),
          SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  width: size.width*0.8,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet<dynamic>(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (context) => Wrap(
                            children: [
                              LoginModal(),
                            ],
                          )
                      );
                    },
                    child: Text('Sign in', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryAccent,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16), // <-- Radius
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 50),
                  width: size.width*0.8,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet<dynamic>(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (context) => Wrap(
                            children: [
                              SignUpModal(),
                            ],
                          )
                      );
                    },
                    child: Text('Sign up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                    style: ElevatedButton.styleFrom(
                      primary: kSecondaryColor,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16), // <-- Radius
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}