import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:splitter/route.dart' as route;
import 'package:splitter/constants.dart';

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class VerifyScreen extends StatefulWidget {
  String password,email,phone;
  VerifyScreen({Key key,@required this.password,@required this.email,@required this.phone}) : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {

  @override
  initState() {
    super.initState();
  }

  bool isLoading = false;
  String currentCode = "";
  String showCode = "○○○○○○";


  void removeLast() {
    if(currentCode.length>0) {
      currentCode = currentCode.substring(0, currentCode.length - 1);
      updateCode();
    }
  }

  void keypadClick(int number) {
    if(currentCode.length < 6) {
      currentCode += number.toString();
      updateCode();
    }
  }

  void updateCode() async {
    String nextShowCode = "";
    if(currentCode.length < 6) {
      for(var i = 0; i < currentCode.length; i++) {
        nextShowCode += "●";
      }
      if (currentCode.length < 6) {
        for(var i = 0; i < 6-currentCode.length; i++) {
          nextShowCode += "○";
        }
      }
    } else {
      isLoading = true;
      setState(()  {
        showCode = "●●●●●●";
      });
      try {
        await Amplify.Auth.signOut();
        await Amplify.Auth.confirmSignUp(
          username: widget.email,
          confirmationCode: currentCode,
        );
        await Amplify.Auth.signIn(
          username: widget.email,
          password: widget.password,
        );
        Navigator.pushReplacementNamed(context, route.homePage);
      } on AuthException catch(e) {

      }
    }
    print(currentCode);
    setState(()  {
      showCode = nextShowCode;
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.arrow_back_ios_rounded, size: 30,),
            SizedBox(height: 20,),
            Text("Enter code sent to \nyour phone", style: TextStyle(height: 1.2, fontSize: 30, fontWeight: FontWeight.bold, color: kDarkHeadingColor),),
            SizedBox(height: 20,),
            Text("Code sent to " + widget.phone, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: kMediumHeadingColor),),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Not your number?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: kMediumHeadingColor),),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(" Resend", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: kPrimaryColor),),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (isLoading) ? CircularProgressIndicator() : Text(showCode, style: TextStyle(letterSpacing: 5, fontSize: 40, fontWeight: FontWeight.w400, color: kDarkHeadingColor)),
              ],
            ),
            SizedBox(height: 30,),

            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: TextButton(
                            onPressed: () {keypadClick(1);},
                            child: Text("1", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: kDarkHeadingColor),),
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith((states) => kBackgroundAccent),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: TextButton(
                            onPressed: () {keypadClick(2);},
                            child: Text("2", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: kDarkHeadingColor),),
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith((states) => kBackgroundAccent),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: TextButton(
                            onPressed: () {keypadClick(3);},
                            child: Text("3", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: kDarkHeadingColor),),
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith((states) => kBackgroundAccent),
                            ),
                          ),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: TextButton(
                            onPressed: () {keypadClick(4);},
                            child: Text("4", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: kDarkHeadingColor),),
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith((states) => kBackgroundAccent),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: TextButton(
                            onPressed: () {keypadClick(5);},
                            child: Text("5", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: kDarkHeadingColor),),
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith((states) => kBackgroundAccent),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: TextButton(
                            onPressed: () {keypadClick(6);},
                            child: Text("6", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: kDarkHeadingColor),),
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith((states) => kBackgroundAccent),
                            ),
                          ),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: TextButton(
                            onPressed: () {keypadClick(7);},
                            child: Text("7", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: kDarkHeadingColor),),
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith((states) => kBackgroundAccent),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: TextButton(
                            onPressed: () {keypadClick(8);},
                            child: Text("8", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: kDarkHeadingColor),),
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith((states) => kBackgroundAccent),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: TextButton(
                            onPressed: () {keypadClick(9);},
                            child: Text("9", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: kDarkHeadingColor),),
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith((states) => kBackgroundAccent),
                            ),
                          ),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                        ),
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: TextButton(
                            onPressed: () {keypadClick(0);},
                            child: Text("0", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: kDarkHeadingColor),),
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith((states) => kBackgroundAccent),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: TextButton(
                            onPressed: () {removeLast();},
                            child: Icon(Icons.backspace_rounded, color: kDarkHeadingColor,),
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith((states) => kBackgroundAccent),
                            ),
                          ),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}