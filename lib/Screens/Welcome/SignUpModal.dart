import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:splitter/constants.dart';
import 'package:splitter/route.dart' as route;
import 'package:splitter/Models/VerifyScreenArguments.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

// Generated in previous step
import 'package:splitter/amplifyconfiguration.dart';

class SignUpModal extends StatefulWidget {
  SignUpModal({Key key}) : super(key: key);

  @override
  _SignUpModalState createState() => _SignUpModalState();
}

class _SignUpModalState extends State<SignUpModal> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  initState() {
    super.initState();
  }

   void  signUpWithMail() async {
    try {
      Map<String, String> userAttributes = {
        'email': emailController.text.trim(),
        'phone_number': phoneController.text.trim(),
        'name': nameController.text,
      };
      SignUpResult res = await Amplify.Auth.signUp(
          username: emailController.text.trim(),
          password: passwordController.text.trim(),
          options: CognitoSignUpOptions(
            userAttributes: userAttributes,
          )
      );
      if(res.isSignUpComplete) {
        Navigator.pushNamed(context, route.verificationPage, arguments: VerifyArguments(email:  emailController.text.trim(), phone: phoneController.text.trim(), password: passwordController.text.trim()));
      }
      print(res.isSignUpComplete);
    } on AuthException catch(e) {
      print(e.message);
    }
 }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {
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
                Text("Sign Up", style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: kDarkHeadingColor,
                ))
              ],
            ),
            SizedBox(height: 25.0),
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
            SizedBox(height: 30.0),
            Text("Or register with email", style: TextStyle(color: kSmallTextColor, fontSize: 18.0, fontWeight: FontWeight.normal), textAlign: TextAlign.center,),
            SizedBox(height: 30.0),
            TextFormField(
              autofillHints: ["email", "mail"],
              textInputAction: TextInputAction.next,
              controller: emailController,
              style: TextStyle(
                  fontSize: 18.0
              ),
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: kSmallTextColor,
                  ),
                  prefixIcon: Icon(Icons.alternate_email_rounded, size: 22,),
                  labelText: "Email",
                  hintText: "Enter email adress",
                  focusColor: kMediumHeadingColor,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kMediumHeadingColor)
                  )
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              autofillHints: ["fullname", "name", "full name"],
              textInputAction: TextInputAction.next,
              controller: nameController,
              style: TextStyle(
                  fontSize: 18.0
              ),
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: kSmallTextColor,
                  ),
                  prefixIcon: Icon(Icons.person_rounded, size: 25,),
                  labelText: "Name",
                  hintText: "Enter your full name",
                  focusColor: kMediumHeadingColor,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kMediumHeadingColor)
                  )
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              keyboardType: TextInputType.phone,
              autofillHints: [AutofillHints.telephoneNumber, AutofillHints.telephoneNumberLocal],
              textInputAction: TextInputAction.next,
              controller: phoneController,
              style: TextStyle(
                  fontSize: 18.0
              ),
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: kSmallTextColor,
                  ),
                  prefixIcon: Icon(Icons.phone_rounded, size: 25,),
                  labelText: "Phone",
                  hintText: "Enter your phone number",
                  focusColor: kMediumHeadingColor,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kMediumHeadingColor)
                  )
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              autofillHints: ["password"],
              textInputAction: TextInputAction.go,
              controller: passwordController,
              obscureText: true,
              style: TextStyle(
                  fontSize: 18.0
              ),
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: kSmallTextColor,
                  ),
                  prefixIcon: Icon(Icons.lock_rounded, size: 24,),
                  labelText: "Password",
                  hintText: "Enter desired password",
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
                onPressed: () {signUpWithMail();},
                child: Text('Sign Up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // <-- Radius
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}