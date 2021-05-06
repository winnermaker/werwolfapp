import 'roles_controller.dart';
import 'roles.dart';
import 'package:flutter/material.dart';

import 'bottombar.dart';

class FirstChoice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FirstChoiceState();
  }
}

class FirstChoiceState extends State<FirstChoice> {
  TextEditingController textFieldController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
              0.1,
              0.3,
              0.6,
              1
            ],
                colors: [
              Colors.white,
              Colors.yellow[100],
              Colors.yellow,
              Colors.yellow[700]
            ])),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: MaterialButton(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3, bottom: 3),
                          child: Text("Alles auswählen"),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            side: BorderSide(
                                width: 3, color: Colors.blueGrey[300])),
                        onPressed: () {
                          setState(() {
                            RolesController().setAllFirstSelected();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BottomBar()));
                          });
                        }),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: MaterialButton(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: Text("Alkohol hinzufügen"),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                              side: BorderSide(
                                  width: 3, color: Colors.blueGrey[300])),
                          onPressed: () async {
                            return showDialog(
                                context: context,
                                child: AlertDialog(
                                    title: Text("Neuer Alkohol!"),
                                    content: SafeArea(
                                        child: TextField(
                                      controller: textFieldController,
                                      decoration: InputDecoration(
                                        helperText: "Hier Alkohol eingeben",
                                      ),
                                    )),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Abbrechen!"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlatButton(
                                          child: Text("Hinzufügen!"),
                                          onPressed: () async {
                                            setState(() {
                                              RolesController().addToAllRoles(
                                                  newRole(
                                                      textFieldController.text,
                                                      textFieldController
                                                          .text));
                                              textFieldController.dispose();
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          BottomBar()));
                                            });
                                          }),
                                    ]));
                          }),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: MaterialButton(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3, bottom: 3),
                          child: Text("Auswahl löschen"),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                            side: BorderSide(
                                width: 3, color: Colors.blueGrey[300])),
                        onPressed: () {
                          setState(() {
                            RolesController().setAllFirstUnselected();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BottomBar()));
                          });
                        }),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child:
                      Column(children: RolesController().getAllFirstWidgets()),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Roles newRole(String name, String description) {
    RolesProperties properties = new RolesProperties(
        RolesController().getAllRoles().length + 1, name, description, 1, 0, 0);
    Roles newFirst = new Roles(properties);
    return newFirst;
  }

  int setIsSelected(bool _isSelected) {
    int temp;
    if (_isSelected == true) {
      temp = 0;
    } else {
      temp = 1;
    }
    return temp;
  }
}
