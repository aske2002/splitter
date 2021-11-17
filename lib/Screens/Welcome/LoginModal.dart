import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:splitter/route.dart' as route;
import 'package:splitter/constants.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class LoginModal extends StatefulWidget {
  @override
  _LoginModalState createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override

  void signIn() async {
    try {
      await Amplify.Auth.signOut();
      await Amplify.Auth.signIn(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context, route.homePage);
    } on AuthException catch (e) {
      print(e.message);
    }
  }
  Widget build(BuildContext context ) {
    Size size = MediaQuery.of(context).size;
    return Theme(
      data: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
            primary: kDarkHeadingColor,
          )
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        decoration:  BoxDecoration(
            color: kSecondaryBackground,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded, color: kDarkHeadingColor),
                  padding: EdgeInsets.only(right: 20.0),
                  iconSize: 30.0,
                  onPressed: () {Navigator.pop(context);},
                ),
                Text("Sign In", style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: kDarkHeadingColor,
                ))
              ],
            ),
            SizedBox(height: 30.0),
            TextFormField(
              controller: usernameController,
              style: TextStyle(
                  fontSize: 18.0
              ),
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: kSmallTextColor,
                  ),
                  prefixIcon: Icon(Icons.alternate_email_rounded, size: 22,),
                  hintText: "Email adress",
                  focusColor: kMediumHeadingColor,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kMediumHeadingColor)
                  )
              ),
            ),
            SizedBox(height: 30.0),
            TextFormField(
              controller: passwordController,
              style: TextStyle(
                  fontSize: 18.0
              ),
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: kSmallTextColor,
                  ),
                  prefixIcon: Icon(Icons.lock_rounded, size: 22,),
                  suffixIcon: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith((states) => Colors.black12),
                    ),
                    child: Text("Forgot password?", style: TextStyle(color: kPrimaryColor, fontSize: 15.0, fontWeight: FontWeight.w500),),
                  ),
                  hintText: "Password",
                  focusColor: kMediumHeadingColor,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kMediumHeadingColor)
                  )
              ),
            ),
            SizedBox(height: 35.0),
            Container(
              height: 55,
              child: ElevatedButton(
                onPressed: () {signIn();},
                child: Text('Sign in', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // <-- Radius
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {},
                child: Image.asset("assets/images/Google.png", height: 30,),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // <-- Radius
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?", style: TextStyle(color: kDarkHeadingColor, fontSize: 16.0, fontWeight: FontWeight.normal),),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith((states) => Colors.black12),
                  ),
                  child: Text("Register", style: TextStyle(color: kPrimaryColor, fontSize: 16.0, fontWeight: FontWeight.w500),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

