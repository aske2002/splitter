import 'package:flutter/material.dart';
import 'package:splitter/constants.dart';
//import 'package:splitter/Screens/Welcome/welcome_screen.dart';
//import 'package:splitter/Screens/Verify/verify_screen.dart';

import 'package:splitter/route.dart' as route;

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
//import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';


// Generated in previous step
import 'amplifyconfiguration.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    super.initState();
  }

  Future<bool> _configureAmplify() async {
    if(Amplify.isConfigured != true) {
      AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
      AmplifyAPI apiPlugin = AmplifyAPI();
      await Amplify.addPlugins([apiPlugin, authPlugin]);
      try {
        await Amplify.configure(amplifyconfig);
      } catch (e) {
        return Future.error("Failed initializing app");
      }
    }
    try {
      AuthUser awsUser = await Amplify.Auth.getCurrentUser();
      print(awsUser.username);
      return true;
    } on AuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _configureAmplify(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container(color: kPrimaryColor,child: Center(child: CircularProgressIndicator(color: Colors.white,)));
          default:
            if (snapshot.hasError) {
              print(snapshot.error);
              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(),
                home: Scaffold(
                  body: Text("Der er sket en stor fed fejl"),
                ),
              );
            } else {
              print(snapshot.data);
              if (snapshot.data) {
                return MaterialApp(
                  title: 'Flutter Demo',
                  theme: ThemeData(),
                  onGenerateRoute: route.controller,
                  initialRoute: route.welcomePage,
                );
              } else {
                return MaterialApp(
                  title: 'Flutter Demo',
                  theme: ThemeData(),
                  onGenerateRoute: route.controller,
                  initialRoute: route.welcomePage,
                );
              }
            }
        }
      }
    );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      onGenerateRoute: route.controller,
      initialRoute: route.welcomePage ,
    );
  }
}
