import 'bottombar.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        body: new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              colorFilter: ColorFilter.matrix(<double>[
                1,
                0,
                0,
                0,
                0,
                0,
                1,
                0,
                0,
                0,
                0,
                0,
                1,
                0,
                0,
                0,
                0,
                0,
                0.3,
                0,
              ]),
              image: new AssetImage("assets/images/welcome.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: new Center(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: new Text(
                    'Werwolf Matchmaking!',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.redAccent[700],
                        fontWeight: FontWeight.w900,
                        decoration: TextDecoration.underline),
                  ),
                ),
                new Center(
                  child: new Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Container(
                      child: new MaterialButton(
                        elevation: 100,
                        color: Colors.blue[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: new Text(
                          'Drücke hier zum Starten',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BottomBar()));
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
