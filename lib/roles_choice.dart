import 'roles_controller.dart';
import 'roles.dart';
import 'package:flutter/material.dart';

import 'bottombar.dart';

class RolesChoice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RolesChoiceState();
  }
}

class RolesChoiceState extends State<RolesChoice> {
  TextEditingController textFieldController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                            RolesController().setAllRolesSelected();
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
                            RolesController().setAllRolesUnselected();
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
                      Column(children: RolesController().getAllRolesWidgets()),
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
    Roles newRoles = new Roles(properties);
    return newRoles;
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
