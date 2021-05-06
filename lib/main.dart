import 'roles_controller.dart';
import 'local_db.dart';
import 'route_manager.dart';
import 'bottombar.dart';
import 'welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DatabaseProvider.db.createDatabase();
    RolesController().setRolesFromDatabase();

    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'Werwolf Matchmaking',
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Welcome()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => BottomBar()));
    }
  }

  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 200), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('Loading...'),
      ),
    );
  }
}
