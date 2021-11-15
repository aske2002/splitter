import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splitter/constants.dart';

class LoginModal extends StatelessWidget {
  @override
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
            color: Colors.white,
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
                ),
                Text("Sign In", style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: kDarkHeadingColor,
                ))
              ],
            ),
            SizedBox(height: 30.0),
            TextFormField(
              style: TextStyle(
                  fontSize: 18.0
              ),
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: kSmallTextColor,
                  ),
                  prefixIcon: Icon(Icons.alternate_email_rounded),
                  hintText: "Email adress",
                  focusColor: kMediumHeadingColor,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kMediumHeadingColor)
                  )
              ),
            ),
            SizedBox(height: 30.0),
            TextFormField(
              style: TextStyle(
                  fontSize: 18.0
              ),
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: kSmallTextColor,
                  ),
                  prefixIcon: Icon(Icons.lock_rounded),
                  suffixIcon: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith((states) => Colors.black12),
                    ),
                    child: Text("Forgot password?", style: TextStyle(color: kPrimaryColor, fontSize: 15.0, fontWeight: FontWeight.normal),),
                  ),
                  hintText: "Password",
                  focusColor: kMediumHeadingColor,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kMediumHeadingColor)
                  )
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              height: 60,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Sign in', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // <-- Radius
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              "Or sign in with",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  color: kSmallTextColor
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
            Row(
              children: [
                
              ],
            )
          ],
        ),
      ),
    );
  }
}