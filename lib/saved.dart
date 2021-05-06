import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'matches.dart';

import 'bottombar.dart';

class Saved extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SavedState();
  }
}

class SavedState extends State<Saved> {
  Widget build(BuildContext context) {
    savedRoles.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/welcome.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Row(children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: MaterialButton(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      side: BorderSide(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Text(
                    "Meine Getränke",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: MaterialButton(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                    child: Text(
                      "Löschen",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      side: BorderSide(color: Colors.white)),
                  onPressed: () async {
                    return showDialog(
                        context: context,
                        child: AlertDialog(
                            title:
                                Text("Meine Getränkeliste komplett löschen!"),
                            content: Text(
                                "Hiermit wird die komplette Liste entfernt !"),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Niemals!")),
                              FlatButton(
                                  onPressed: () async {
                                    savedRoles.clear();
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Text("Weg damit!"))
                            ]));
                  },
                ),
              ),
            ]),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: savedRoles.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(
                      savedRoles[index],
                      style: TextStyle(color: Colors.white),
                    ));
                  },
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
